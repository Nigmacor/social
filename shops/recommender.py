import redis
from django.conf import settings

from .models import ServiceType

#подключаю redis и определяю REDIS_DB = 1 для обработки рекомендаций
REDIS_DB = 1
r = redis.StrictRedis(host=settings.REDIS_HOST,
                      port=settings.REDIS_PORT,
                      db=REDIS_DB)


class Recommender(object):

    def get_product_key(self, id):
        return 'product:{}:purchased_with'.format(id)

    def products_bought(self, products):
        product_ids = [p.id for p in products]
        for product in product_ids:
            for with_id in product_ids:
                if product != with_id:
                    r.zincrby(self.get_product_key(product), 1, with_id)

    def suggest_products_for(self, products, max_result=6):
        product_ids = [p.id for p in products]
        if len(product_ids)==1:
            suggestions = r.zrange(self.get_product_key(product_ids[0]),
                                  0, -1, desc=True)[:max_result]
        elif len(product_ids)>=1:
            # Формирую временный ключ хранилища
            flat_ids = ''.join([str(id) for id in product_ids])
            tmp_key = 'tmp_{}'.format(flat_ids)
            # Передано несколько товаров, суммирую рейтинги их рекомендаций
            # Сохраняю суммы во временном ключе
            keys = [self.get_product_key(id) for id in product_ids]
            r.zunionstore(tmp_key, keys)
            # Удаляю ID товаров, которые были переданы в списке
            r.zrem(tmp_key, *product_ids)
            # Товары, отсортированные по рейтингу
            suggestions = r.zrange(tmp_key, 0, -1, desc=True)[:max_result]
            # Удаляею временный ключ хранилища
            r.delete(tmp_key)
        else:
            return None
        suggested_products_ids = [int(id) for id in suggestions]
        suggested_products = list(ServiceType.objects.filter(id__in=suggested_products_ids))
        suggested_products.sort(key=lambda x: suggested_products_ids.index(x.id))
        return suggested_products

    def clear_purchases(self):
        for id in ServiceType.objects.values_list('id', flat=True):
            r.delete(self.get_product_key(id))

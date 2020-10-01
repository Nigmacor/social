PGDMP             
            x            soci    13.0    13.0 9   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17647    soci    DATABASE     a   CREATE DATABASE soci WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE soci;
             	   mplace_db    false            �            1259    17881    account_contact    TABLE     �   CREATE TABLE public.account_contact (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    user_from_id integer NOT NULL,
    user_to_id integer NOT NULL
);
 #   DROP TABLE public.account_contact;
       public         heap 	   mplace_db    false            �            1259    17879    account_contact_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.account_contact_id_seq;
       public       	   mplace_db    false    231            �           0    0    account_contact_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.account_contact_id_seq OWNED BY public.account_contact.id;
          public       	   mplace_db    false    230            �            1259    17889    account_dialogs    TABLE     �   CREATE TABLE public.account_dialogs (
    id integer NOT NULL,
    room_id integer NOT NULL,
    user_from_id integer NOT NULL,
    user_to_id integer NOT NULL
);
 #   DROP TABLE public.account_dialogs;
       public         heap 	   mplace_db    false            �            1259    17887    account_dialogs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_dialogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.account_dialogs_id_seq;
       public       	   mplace_db    false    233            �           0    0    account_dialogs_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.account_dialogs_id_seq OWNED BY public.account_dialogs.id;
          public       	   mplace_db    false    232            �            1259    17862    account_profession    TABLE     �   CREATE TABLE public.account_profession (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    url character varying(200) NOT NULL,
    description text NOT NULL
);
 &   DROP TABLE public.account_profession;
       public         heap 	   mplace_db    false            �            1259    17860    account_profession_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_profession_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.account_profession_id_seq;
       public       	   mplace_db    false    227            �           0    0    account_profession_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.account_profession_id_seq OWNED BY public.account_profession.id;
          public       	   mplace_db    false    226            �            1259    17852    account_profile    TABLE     �   CREATE TABLE public.account_profile (
    id integer NOT NULL,
    date_of_birth date,
    photo character varying(100) NOT NULL,
    user_id integer NOT NULL
);
 #   DROP TABLE public.account_profile;
       public         heap 	   mplace_db    false            �            1259    17850    account_profile_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.account_profile_id_seq;
       public       	   mplace_db    false    225            �           0    0    account_profile_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.account_profile_id_seq OWNED BY public.account_profile.id;
          public       	   mplace_db    false    224            �            1259    17873    account_profiletoprofession    TABLE     �   CREATE TABLE public.account_profiletoprofession (
    id integer NOT NULL,
    confirmed boolean NOT NULL,
    profession_id integer NOT NULL,
    worker_id integer NOT NULL,
    created timestamp with time zone NOT NULL
);
 /   DROP TABLE public.account_profiletoprofession;
       public         heap 	   mplace_db    false            �            1259    17871 "   account_profiletoprofession_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_profiletoprofession_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.account_profiletoprofession_id_seq;
       public       	   mplace_db    false    229            �           0    0 "   account_profiletoprofession_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.account_profiletoprofession_id_seq OWNED BY public.account_profiletoprofession.id;
          public       	   mplace_db    false    228            �            1259    17948    actions_action    TABLE     Y  CREATE TABLE public.actions_action (
    id integer NOT NULL,
    verb character varying(255) NOT NULL,
    target_id integer,
    created timestamp with time zone NOT NULL,
    target_ct_id integer,
    user_id integer NOT NULL,
    type character varying(25) NOT NULL,
    CONSTRAINT actions_action_target_id_check CHECK ((target_id >= 0))
);
 "   DROP TABLE public.actions_action;
       public         heap 	   mplace_db    false            �            1259    17946    actions_action_id_seq    SEQUENCE     �   CREATE SEQUENCE public.actions_action_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.actions_action_id_seq;
       public       	   mplace_db    false    235            �           0    0    actions_action_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.actions_action_id_seq OWNED BY public.actions_action.id;
          public       	   mplace_db    false    234            �            1259    17679 
   auth_group    TABLE     f   CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);
    DROP TABLE public.auth_group;
       public         heap 	   mplace_db    false            �            1259    17677    auth_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.auth_group_id_seq;
       public       	   mplace_db    false    207            �           0    0    auth_group_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;
          public       	   mplace_db    false    206            �            1259    17689    auth_group_permissions    TABLE     �   CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);
 *   DROP TABLE public.auth_group_permissions;
       public         heap 	   mplace_db    false            �            1259    17687    auth_group_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.auth_group_permissions_id_seq;
       public       	   mplace_db    false    209            �           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;
          public       	   mplace_db    false    208            �            1259    17671    auth_permission    TABLE     �   CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);
 #   DROP TABLE public.auth_permission;
       public         heap 	   mplace_db    false            �            1259    17669    auth_permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auth_permission_id_seq;
       public       	   mplace_db    false    205            �           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;
          public       	   mplace_db    false    204            �            1259    17697 	   auth_user    TABLE     �  CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);
    DROP TABLE public.auth_user;
       public         heap 	   mplace_db    false            �            1259    17707    auth_user_groups    TABLE        CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);
 $   DROP TABLE public.auth_user_groups;
       public         heap 	   mplace_db    false            �            1259    17705    auth_user_groups_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.auth_user_groups_id_seq;
       public       	   mplace_db    false    213            �           0    0    auth_user_groups_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;
          public       	   mplace_db    false    212            �            1259    17695    auth_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.auth_user_id_seq;
       public       	   mplace_db    false    211            �           0    0    auth_user_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;
          public       	   mplace_db    false    210            �            1259    17715    auth_user_user_permissions    TABLE     �   CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);
 .   DROP TABLE public.auth_user_user_permissions;
       public         heap 	   mplace_db    false            �            1259    17713 !   auth_user_user_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.auth_user_user_permissions_id_seq;
       public       	   mplace_db    false    215            �           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;
          public       	   mplace_db    false    214            �            1259    17791    chat_chatmessage    TABLE     �   CREATE TABLE public.chat_chatmessage (
    id integer NOT NULL,
    message text NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    chat_id integer NOT NULL,
    user_id integer NOT NULL
);
 $   DROP TABLE public.chat_chatmessage;
       public         heap 	   mplace_db    false            �            1259    17789    chat_chatmessage_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chat_chatmessage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.chat_chatmessage_id_seq;
       public       	   mplace_db    false    221            �           0    0    chat_chatmessage_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.chat_chatmessage_id_seq OWNED BY public.chat_chatmessage.id;
          public       	   mplace_db    false    220            �            1259    17802    chat_chatmessagepack    TABLE     �   CREATE TABLE public.chat_chatmessagepack (
    id integer NOT NULL,
    pack text NOT NULL,
    created timestamp with time zone NOT NULL,
    chat_id integer NOT NULL,
    previous_id integer
);
 (   DROP TABLE public.chat_chatmessagepack;
       public         heap 	   mplace_db    false            �            1259    17800    chat_chatmessagepack_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chat_chatmessagepack_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.chat_chatmessagepack_id_seq;
       public       	   mplace_db    false    223            �           0    0    chat_chatmessagepack_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.chat_chatmessagepack_id_seq OWNED BY public.chat_chatmessagepack.id;
          public       	   mplace_db    false    222            �            1259    17775 	   chat_room    TABLE     �   CREATE TABLE public.chat_room (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    staff_only boolean NOT NULL
);
    DROP TABLE public.chat_room;
       public         heap 	   mplace_db    false            �            1259    17773    chat_room_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chat_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.chat_room_id_seq;
       public       	   mplace_db    false    217            �           0    0    chat_room_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.chat_room_id_seq OWNED BY public.chat_room.id;
          public       	   mplace_db    false    216            �            1259    17783    chat_room_members    TABLE        CREATE TABLE public.chat_room_members (
    id integer NOT NULL,
    room_id integer NOT NULL,
    user_id integer NOT NULL
);
 %   DROP TABLE public.chat_room_members;
       public         heap 	   mplace_db    false            �            1259    17781    chat_room_members_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chat_room_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.chat_room_members_id_seq;
       public       	   mplace_db    false    219            �           0    0    chat_room_members_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.chat_room_members_id_seq OWNED BY public.chat_room_members.id;
          public       	   mplace_db    false    218            �            1259    18005    coupons_coupon    TABLE       CREATE TABLE public.coupons_coupon (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    valid_from timestamp with time zone NOT NULL,
    valid_to timestamp with time zone NOT NULL,
    discount integer NOT NULL,
    active boolean NOT NULL
);
 "   DROP TABLE public.coupons_coupon;
       public         heap 	   mplace_db    false            �            1259    18003    coupons_coupon_id_seq    SEQUENCE     �   CREATE SEQUENCE public.coupons_coupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.coupons_coupon_id_seq;
       public       	   mplace_db    false    239            �           0    0    coupons_coupon_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.coupons_coupon_id_seq OWNED BY public.coupons_coupon.id;
          public       	   mplace_db    false    238            �            1259    17972    django_admin_log    TABLE     �  CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);
 $   DROP TABLE public.django_admin_log;
       public         heap 	   mplace_db    false            �            1259    17970    django_admin_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.django_admin_log_id_seq;
       public       	   mplace_db    false    237            �           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;
          public       	   mplace_db    false    236            �            1259    17661    django_content_type    TABLE     �   CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);
 '   DROP TABLE public.django_content_type;
       public         heap 	   mplace_db    false            �            1259    17659    django_content_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.django_content_type_id_seq;
       public       	   mplace_db    false    203            �           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;
          public       	   mplace_db    false    202            �            1259    17650    django_migrations    TABLE     �   CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);
 %   DROP TABLE public.django_migrations;
       public         heap 	   mplace_db    false            �            1259    17648    django_migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.django_migrations_id_seq;
       public       	   mplace_db    false    201            �           0    0    django_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;
          public       	   mplace_db    false    200            +           1259    18667    django_session    TABLE     �   CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);
 "   DROP TABLE public.django_session;
       public         heap 	   mplace_db    false            �            1259    18064    images_galary    TABLE     �   CREATE TABLE public.images_galary (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    title character varying(200) NOT NULL,
    slug character varying(255) NOT NULL,
    user_id integer NOT NULL
);
 !   DROP TABLE public.images_galary;
       public         heap 	   mplace_db    false            �            1259    18062    images_galary_id_seq    SEQUENCE     �   CREATE SEQUENCE public.images_galary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.images_galary_id_seq;
       public       	   mplace_db    false    245            �           0    0    images_galary_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.images_galary_id_seq OWNED BY public.images_galary.id;
          public       	   mplace_db    false    244            �            1259    18016    images_image    TABLE     �  CREATE TABLE public.images_image (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    slug character varying(255) NOT NULL,
    url character varying(200) NOT NULL,
    image character varying(100) NOT NULL,
    description text NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    total_likes integer NOT NULL,
    is_public boolean NOT NULL,
    CONSTRAINT images_image_total_likes_check CHECK ((total_likes >= 0))
);
     DROP TABLE public.images_image;
       public         heap 	   mplace_db    false            �            1259    18014    images_image_id_seq    SEQUENCE     �   CREATE SEQUENCE public.images_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.images_image_id_seq;
       public       	   mplace_db    false    241            �           0    0    images_image_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.images_image_id_seq OWNED BY public.images_image.id;
          public       	   mplace_db    false    240            �            1259    18027    images_image_users_like    TABLE     �   CREATE TABLE public.images_image_users_like (
    id integer NOT NULL,
    image_id integer NOT NULL,
    user_id integer NOT NULL
);
 +   DROP TABLE public.images_image_users_like;
       public         heap 	   mplace_db    false            �            1259    18025    images_image_users_like_id_seq    SEQUENCE     �   CREATE SEQUENCE public.images_image_users_like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.images_image_users_like_id_seq;
       public       	   mplace_db    false    243                        0    0    images_image_users_like_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.images_image_users_like_id_seq OWNED BY public.images_image_users_like.id;
          public       	   mplace_db    false    242                       1259    18387    orders_order    TABLE     y  CREATE TABLE public.orders_order (
    id integer NOT NULL,
    last_name character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    patronymic character varying(50) NOT NULL,
    email character varying(254) NOT NULL,
    address character varying(255) NOT NULL,
    postal_code character varying(20) NOT NULL,
    city character varying(100) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    paid boolean NOT NULL,
    user_id integer NOT NULL,
    payment_id character varying(150) NOT NULL,
    coupon_id integer,
    discount integer NOT NULL
);
     DROP TABLE public.orders_order;
       public         heap 	   mplace_db    false                       1259    18385    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public       	   mplace_db    false    274                       0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders_order.id;
          public       	   mplace_db    false    273                       1259    18398    orders_orderitem    TABLE     )  CREATE TABLE public.orders_orderitem (
    id integer NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    shop_id integer NOT NULL,
    CONSTRAINT orders_orderitem_quantity_check CHECK ((quantity >= 0))
);
 $   DROP TABLE public.orders_orderitem;
       public         heap 	   mplace_db    false                       1259    18396    orders_orderitem_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_orderitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.orders_orderitem_id_seq;
       public       	   mplace_db    false    276                       0    0    orders_orderitem_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.orders_orderitem_id_seq OWNED BY public.orders_orderitem.id;
          public       	   mplace_db    false    275            $           1259    18519    projects_benchmark    TABLE     �   CREATE TABLE public.projects_benchmark (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    status boolean NOT NULL,
    deadline date NOT NULL,
    module_id integer NOT NULL
);
 &   DROP TABLE public.projects_benchmark;
       public         heap 	   mplace_db    false            #           1259    18517    projects_benchmark_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_benchmark_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.projects_benchmark_id_seq;
       public       	   mplace_db    false    292                       0    0    projects_benchmark_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.projects_benchmark_id_seq OWNED BY public.projects_benchmark.id;
          public       	   mplace_db    false    291            "           1259    18510    projects_content    TABLE     �   CREATE TABLE public.projects_content (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    module_id integer NOT NULL,
    CONSTRAINT projects_content_object_id_check CHECK ((object_id >= 0))
);
 $   DROP TABLE public.projects_content;
       public         heap 	   mplace_db    false            !           1259    18508    projects_content_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.projects_content_id_seq;
       public       	   mplace_db    false    290                       0    0    projects_content_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.projects_content_id_seq OWNED BY public.projects_content.id;
          public       	   mplace_db    false    289            (           1259    18540    projects_family    TABLE     �   CREATE TABLE public.projects_family (
    id integer NOT NULL,
    childrens_id integer NOT NULL,
    parents_id integer NOT NULL
);
 #   DROP TABLE public.projects_family;
       public         heap 	   mplace_db    false            '           1259    18538    projects_family_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_family_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.projects_family_id_seq;
       public       	   mplace_db    false    296                       0    0    projects_family_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.projects_family_id_seq OWNED BY public.projects_family.id;
          public       	   mplace_db    false    295                        1259    18502    projects_file    TABLE       CREATE TABLE public.projects_file (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    file character varying(100) NOT NULL,
    producer_id integer NOT NULL
);
 !   DROP TABLE public.projects_file;
       public         heap 	   mplace_db    false                       1259    18500    projects_file_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.projects_file_id_seq;
       public       	   mplace_db    false    288                       0    0    projects_file_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.projects_file_id_seq OWNED BY public.projects_file.id;
          public       	   mplace_db    false    287                       1259    18494    projects_image    TABLE       CREATE TABLE public.projects_image (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    image character varying(100) NOT NULL,
    producer_id integer NOT NULL
);
 "   DROP TABLE public.projects_image;
       public         heap 	   mplace_db    false                       1259    18492    projects_image_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.projects_image_id_seq;
       public       	   mplace_db    false    286                       0    0    projects_image_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.projects_image_id_seq OWNED BY public.projects_image.id;
          public       	   mplace_db    false    285                       1259    18483    projects_module    TABLE        CREATE TABLE public.projects_module (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    complited boolean NOT NULL,
    project_id integer NOT NULL,
    producer_id integer,
    profession_id integer
);
 #   DROP TABLE public.projects_module;
       public         heap 	   mplace_db    false                       1259    18481    projects_module_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.projects_module_id_seq;
       public       	   mplace_db    false    284                       0    0    projects_module_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.projects_module_id_seq OWNED BY public.projects_module.id;
          public       	   mplace_db    false    283            &           1259    18530    projects_producer    TABLE     �   CREATE TABLE public.projects_producer (
    id integer NOT NULL,
    take timestamp with time zone NOT NULL,
    producer_id integer NOT NULL
);
 %   DROP TABLE public.projects_producer;
       public         heap 	   mplace_db    false            %           1259    18528    projects_producer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_producer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.projects_producer_id_seq;
       public       	   mplace_db    false    294            	           0    0    projects_producer_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.projects_producer_id_seq OWNED BY public.projects_producer.id;
          public       	   mplace_db    false    293                       1259    18470    projects_project    TABLE     <  CREATE TABLE public.projects_project (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    description text NOT NULL,
    created timestamp with time zone NOT NULL,
    complited boolean NOT NULL,
    customer_id integer NOT NULL,
    type_id integer
);
 $   DROP TABLE public.projects_project;
       public         heap 	   mplace_db    false                       1259    18468    projects_project_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.projects_project_id_seq;
       public       	   mplace_db    false    282            
           0    0    projects_project_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.projects_project_id_seq OWNED BY public.projects_project.id;
          public       	   mplace_db    false    281            *           1259    18548    projects_projectrespond    TABLE     )  CREATE TABLE public.projects_projectrespond (
    id integer NOT NULL,
    cost numeric(10,2) NOT NULL,
    description text NOT NULL,
    garanty character varying(1024) NOT NULL,
    created timestamp with time zone NOT NULL,
    module_id integer NOT NULL,
    responded_id integer NOT NULL
);
 +   DROP TABLE public.projects_projectrespond;
       public         heap 	   mplace_db    false            )           1259    18546    projects_projectrespond_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_projectrespond_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.projects_projectrespond_id_seq;
       public       	   mplace_db    false    298                       0    0    projects_projectrespond_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.projects_projectrespond_id_seq OWNED BY public.projects_projectrespond.id;
          public       	   mplace_db    false    297                       1259    18459    projects_text    TABLE       CREATE TABLE public.projects_text (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    content text NOT NULL,
    producer_id integer NOT NULL
);
 !   DROP TABLE public.projects_text;
       public         heap 	   mplace_db    false                       1259    18457    projects_text_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_text_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.projects_text_id_seq;
       public       	   mplace_db    false    280                       0    0    projects_text_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.projects_text_id_seq OWNED BY public.projects_text.id;
          public       	   mplace_db    false    279            .           1259    18704    projects_typeofwork    TABLE     2  CREATE TABLE public.projects_typeofwork (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    CONSTRAINT projects_typeofwork_level_check CHECK ((level >= 0)),
    CONSTRAINT projects_typeofwork_lft_check CHECK ((lft >= 0)),
    CONSTRAINT projects_typeofwork_rght_check CHECK ((rght >= 0)),
    CONSTRAINT projects_typeofwork_tree_id_check CHECK ((tree_id >= 0))
);
 '   DROP TABLE public.projects_typeofwork;
       public         heap 	   mplace_db    false            -           1259    18702    projects_typeofwork_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_typeofwork_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.projects_typeofwork_id_seq;
       public       	   mplace_db    false    302                       0    0    projects_typeofwork_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.projects_typeofwork_id_seq OWNED BY public.projects_typeofwork.id;
          public       	   mplace_db    false    301                       1259    18437    projects_video    TABLE       CREATE TABLE public.projects_video (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    url character varying(200) NOT NULL,
    producer_id integer NOT NULL
);
 "   DROP TABLE public.projects_video;
       public         heap 	   mplace_db    false                       1259    18435    projects_video_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_video_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.projects_video_id_seq;
       public       	   mplace_db    false    278                       0    0    projects_video_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.projects_video_id_seq OWNED BY public.projects_video.id;
          public       	   mplace_db    false    277            �            1259    18084    shops_category    TABLE       CREATE TABLE public.shops_category (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    CONSTRAINT shops_category_level_check CHECK ((level >= 0)),
    CONSTRAINT shops_category_lft_check CHECK ((lft >= 0)),
    CONSTRAINT shops_category_rght_check CHECK ((rght >= 0)),
    CONSTRAINT shops_category_tree_id_check CHECK ((tree_id >= 0))
);
 "   DROP TABLE public.shops_category;
       public         heap 	   mplace_db    false            �            1259    18082    shops_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.shops_category_id_seq;
       public       	   mplace_db    false    247                       0    0    shops_category_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.shops_category_id_seq OWNED BY public.shops_category.id;
          public       	   mplace_db    false    246            
           1259    18194 
   shops_file    TABLE     3  CREATE TABLE public.shops_file (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    file character varying(100) NOT NULL,
    product_id integer NOT NULL,
    publisher_id integer NOT NULL
);
    DROP TABLE public.shops_file;
       public         heap 	   mplace_db    false            	           1259    18192    shops_file_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.shops_file_id_seq;
       public       	   mplace_db    false    266                       0    0    shops_file_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.shops_file_id_seq OWNED BY public.shops_file.id;
          public       	   mplace_db    false    265                       1259    18186    shops_image    TABLE     5  CREATE TABLE public.shops_image (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    image character varying(100) NOT NULL,
    product_id integer NOT NULL,
    publisher_id integer NOT NULL
);
    DROP TABLE public.shops_image;
       public         heap 	   mplace_db    false                       1259    18184    shops_image_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.shops_image_id_seq;
       public       	   mplace_db    false    264                       0    0    shops_image_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.shops_image_id_seq OWNED BY public.shops_image.id;
          public       	   mplace_db    false    263            �            1259    18129    shops_product    TABLE     l  CREATE TABLE public.shops_product (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    slug character varying(150) NOT NULL,
    short_description character varying(200) NOT NULL,
    description text NOT NULL,
    information text NOT NULL,
    price numeric(10,2) NOT NULL,
    county integer NOT NULL,
    available boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    category_id integer NOT NULL,
    shop_id integer NOT NULL,
    service_type_id integer NOT NULL,
    CONSTRAINT shops_product_county_check CHECK ((county >= 0))
);
 !   DROP TABLE public.shops_product;
       public         heap 	   mplace_db    false            �            1259    18127    shops_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shops_product_id_seq;
       public       	   mplace_db    false    255                       0    0    shops_product_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shops_product_id_seq OWNED BY public.shops_product.id;
          public       	   mplace_db    false    254                       1259    18202    shops_productcontent    TABLE     a  CREATE TABLE public.shops_productcontent (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "order" integer NOT NULL,
    content_type_id integer NOT NULL,
    product_id integer NOT NULL,
    CONSTRAINT shops_productcontent_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT shops_productcontent_order_check CHECK (("order" >= 0))
);
 (   DROP TABLE public.shops_productcontent;
       public         heap 	   mplace_db    false                       1259    18200    shops_productcontent_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_productcontent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.shops_productcontent_id_seq;
       public       	   mplace_db    false    268                       0    0    shops_productcontent_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.shops_productcontent_id_seq OWNED BY public.shops_productcontent.id;
          public       	   mplace_db    false    267                       1259    18160    shops_productgalary    TABLE     �   CREATE TABLE public.shops_productgalary (
    id integer NOT NULL,
    main_image character varying(200),
    service_id integer NOT NULL
);
 '   DROP TABLE public.shops_productgalary;
       public         heap 	   mplace_db    false                       1259    18158    shops_productgalary_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_productgalary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.shops_productgalary_id_seq;
       public       	   mplace_db    false    259                       0    0    shops_productgalary_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.shops_productgalary_id_seq OWNED BY public.shops_productgalary.id;
          public       	   mplace_db    false    258                       1259    18168    shops_productimage    TABLE     �   CREATE TABLE public.shops_productimage (
    image_ptr_id integer NOT NULL,
    is_main boolean NOT NULL,
    galary_id integer NOT NULL
);
 &   DROP TABLE public.shops_productimage;
       public         heap 	   mplace_db    false                       1259    18145    shops_service    TABLE     �  CREATE TABLE public.shops_service (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    slug character varying(150) NOT NULL,
    short_description character varying(200) NOT NULL,
    description text NOT NULL,
    information text NOT NULL,
    available boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    category_id integer NOT NULL,
    shop_id integer NOT NULL,
    service_type_id integer NOT NULL
);
 !   DROP TABLE public.shops_service;
       public         heap 	   mplace_db    false                        1259    18143    shops_service_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shops_service_id_seq;
       public       	   mplace_db    false    257                       0    0    shops_service_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shops_service_id_seq OWNED BY public.shops_service.id;
          public       	   mplace_db    false    256            �            1259    18121    shops_servicetype    TABLE     C   CREATE TABLE public.shops_servicetype (
    id integer NOT NULL
);
 %   DROP TABLE public.shops_servicetype;
       public         heap 	   mplace_db    false            �            1259    18119    shops_servicetype_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_servicetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.shops_servicetype_id_seq;
       public       	   mplace_db    false    253                       0    0    shops_servicetype_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.shops_servicetype_id_seq OWNED BY public.shops_servicetype.id;
          public       	   mplace_db    false    252            �            1259    18098 
   shops_shop    TABLE     q  CREATE TABLE public.shops_shop (
    id integer NOT NULL,
    name character varying(92) NOT NULL,
    slug character varying(92) NOT NULL,
    title character varying(92) NOT NULL,
    contact_email character varying(254) NOT NULL,
    contact_phone character varying(128) NOT NULL,
    template_prefix character varying(92) NOT NULL,
    owner_id integer NOT NULL
);
    DROP TABLE public.shops_shop;
       public         heap 	   mplace_db    false            �            1259    18113    shops_shop_employes    TABLE     �   CREATE TABLE public.shops_shop_employes (
    id integer NOT NULL,
    shop_id integer NOT NULL,
    user_id integer NOT NULL
);
 '   DROP TABLE public.shops_shop_employes;
       public         heap 	   mplace_db    false            �            1259    18111    shops_shop_employes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_shop_employes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.shops_shop_employes_id_seq;
       public       	   mplace_db    false    251                       0    0    shops_shop_employes_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.shops_shop_employes_id_seq OWNED BY public.shops_shop_employes.id;
          public       	   mplace_db    false    250            �            1259    18096    shops_shop_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_shop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.shops_shop_id_seq;
       public       	   mplace_db    false    249                       0    0    shops_shop_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.shops_shop_id_seq OWNED BY public.shops_shop.id;
          public       	   mplace_db    false    248                       1259    18175 
   shops_text    TABLE     !  CREATE TABLE public.shops_text (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    text text NOT NULL,
    product_id integer NOT NULL,
    publisher_id integer NOT NULL
);
    DROP TABLE public.shops_text;
       public         heap 	   mplace_db    false                       1259    18173    shops_text_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_text_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.shops_text_id_seq;
       public       	   mplace_db    false    262                       0    0    shops_text_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.shops_text_id_seq OWNED BY public.shops_text.id;
          public       	   mplace_db    false    261                       1259    18212    shops_wishlist    TABLE     _   CREATE TABLE public.shops_wishlist (
    id integer NOT NULL,
    owner_id integer NOT NULL
);
 "   DROP TABLE public.shops_wishlist;
       public         heap 	   mplace_db    false                       1259    18210    shops_wishlist_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_wishlist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.shops_wishlist_id_seq;
       public       	   mplace_db    false    270                       0    0    shops_wishlist_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.shops_wishlist_id_seq OWNED BY public.shops_wishlist.id;
          public       	   mplace_db    false    269                       1259    18222    shops_wishlist_products    TABLE     �   CREATE TABLE public.shops_wishlist_products (
    id integer NOT NULL,
    wishlist_id integer NOT NULL,
    servicetype_id integer NOT NULL
);
 +   DROP TABLE public.shops_wishlist_products;
       public         heap 	   mplace_db    false                       1259    18220    shops_wishlist_products_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shops_wishlist_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.shops_wishlist_products_id_seq;
       public       	   mplace_db    false    272                       0    0    shops_wishlist_products_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.shops_wishlist_products_id_seq OWNED BY public.shops_wishlist_products.id;
          public       	   mplace_db    false    271            ,           1259    18692    thumbnail_kvstore    TABLE     l   CREATE TABLE public.thumbnail_kvstore (
    key character varying(200) NOT NULL,
    value text NOT NULL
);
 %   DROP TABLE public.thumbnail_kvstore;
       public         heap 	   mplace_db    false            v           2604    17884    account_contact id    DEFAULT     x   ALTER TABLE ONLY public.account_contact ALTER COLUMN id SET DEFAULT nextval('public.account_contact_id_seq'::regclass);
 A   ALTER TABLE public.account_contact ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    231    230    231            w           2604    17892    account_dialogs id    DEFAULT     x   ALTER TABLE ONLY public.account_dialogs ALTER COLUMN id SET DEFAULT nextval('public.account_dialogs_id_seq'::regclass);
 A   ALTER TABLE public.account_dialogs ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    233    232    233            t           2604    17865    account_profession id    DEFAULT     ~   ALTER TABLE ONLY public.account_profession ALTER COLUMN id SET DEFAULT nextval('public.account_profession_id_seq'::regclass);
 D   ALTER TABLE public.account_profession ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    227    226    227            s           2604    17855    account_profile id    DEFAULT     x   ALTER TABLE ONLY public.account_profile ALTER COLUMN id SET DEFAULT nextval('public.account_profile_id_seq'::regclass);
 A   ALTER TABLE public.account_profile ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    224    225    225            u           2604    17876    account_profiletoprofession id    DEFAULT     �   ALTER TABLE ONLY public.account_profiletoprofession ALTER COLUMN id SET DEFAULT nextval('public.account_profiletoprofession_id_seq'::regclass);
 M   ALTER TABLE public.account_profiletoprofession ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    229    228    229            x           2604    17951    actions_action id    DEFAULT     v   ALTER TABLE ONLY public.actions_action ALTER COLUMN id SET DEFAULT nextval('public.actions_action_id_seq'::regclass);
 @   ALTER TABLE public.actions_action ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    234    235    235            j           2604    17682    auth_group id    DEFAULT     n   ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    206    207    207            k           2604    17692    auth_group_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    209    208    209            i           2604    17674    auth_permission id    DEFAULT     x   ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    205    204    205            l           2604    17700    auth_user id    DEFAULT     l   ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);
 ;   ALTER TABLE public.auth_user ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    211    210    211            m           2604    17710    auth_user_groups id    DEFAULT     z   ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);
 B   ALTER TABLE public.auth_user_groups ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    212    213    213            n           2604    17718    auth_user_user_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);
 L   ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    214    215    215            q           2604    17794    chat_chatmessage id    DEFAULT     z   ALTER TABLE ONLY public.chat_chatmessage ALTER COLUMN id SET DEFAULT nextval('public.chat_chatmessage_id_seq'::regclass);
 B   ALTER TABLE public.chat_chatmessage ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    220    221    221            r           2604    17805    chat_chatmessagepack id    DEFAULT     �   ALTER TABLE ONLY public.chat_chatmessagepack ALTER COLUMN id SET DEFAULT nextval('public.chat_chatmessagepack_id_seq'::regclass);
 F   ALTER TABLE public.chat_chatmessagepack ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    222    223    223            o           2604    17778    chat_room id    DEFAULT     l   ALTER TABLE ONLY public.chat_room ALTER COLUMN id SET DEFAULT nextval('public.chat_room_id_seq'::regclass);
 ;   ALTER TABLE public.chat_room ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    216    217    217            p           2604    17786    chat_room_members id    DEFAULT     |   ALTER TABLE ONLY public.chat_room_members ALTER COLUMN id SET DEFAULT nextval('public.chat_room_members_id_seq'::regclass);
 C   ALTER TABLE public.chat_room_members ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    219    218    219            |           2604    18008    coupons_coupon id    DEFAULT     v   ALTER TABLE ONLY public.coupons_coupon ALTER COLUMN id SET DEFAULT nextval('public.coupons_coupon_id_seq'::regclass);
 @   ALTER TABLE public.coupons_coupon ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    238    239    239            z           2604    17975    django_admin_log id    DEFAULT     z   ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    236    237    237            h           2604    17664    django_content_type id    DEFAULT     �   ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    202    203    203            g           2604    17653    django_migrations id    DEFAULT     |   ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    201    200    201            �           2604    18067    images_galary id    DEFAULT     t   ALTER TABLE ONLY public.images_galary ALTER COLUMN id SET DEFAULT nextval('public.images_galary_id_seq'::regclass);
 ?   ALTER TABLE public.images_galary ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    244    245    245            }           2604    18019    images_image id    DEFAULT     r   ALTER TABLE ONLY public.images_image ALTER COLUMN id SET DEFAULT nextval('public.images_image_id_seq'::regclass);
 >   ALTER TABLE public.images_image ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    240    241    241                       2604    18030    images_image_users_like id    DEFAULT     �   ALTER TABLE ONLY public.images_image_users_like ALTER COLUMN id SET DEFAULT nextval('public.images_image_users_like_id_seq'::regclass);
 I   ALTER TABLE public.images_image_users_like ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    242    243    243            �           2604    18390    orders_order id    DEFAULT     r   ALTER TABLE ONLY public.orders_order ALTER COLUMN id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders_order ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    274    273    274            �           2604    18401    orders_orderitem id    DEFAULT     z   ALTER TABLE ONLY public.orders_orderitem ALTER COLUMN id SET DEFAULT nextval('public.orders_orderitem_id_seq'::regclass);
 B   ALTER TABLE public.orders_orderitem ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    276    275    276            �           2604    18522    projects_benchmark id    DEFAULT     ~   ALTER TABLE ONLY public.projects_benchmark ALTER COLUMN id SET DEFAULT nextval('public.projects_benchmark_id_seq'::regclass);
 D   ALTER TABLE public.projects_benchmark ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    292    291    292            �           2604    18513    projects_content id    DEFAULT     z   ALTER TABLE ONLY public.projects_content ALTER COLUMN id SET DEFAULT nextval('public.projects_content_id_seq'::regclass);
 B   ALTER TABLE public.projects_content ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    290    289    290            �           2604    18543    projects_family id    DEFAULT     x   ALTER TABLE ONLY public.projects_family ALTER COLUMN id SET DEFAULT nextval('public.projects_family_id_seq'::regclass);
 A   ALTER TABLE public.projects_family ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    295    296    296            �           2604    18505    projects_file id    DEFAULT     t   ALTER TABLE ONLY public.projects_file ALTER COLUMN id SET DEFAULT nextval('public.projects_file_id_seq'::regclass);
 ?   ALTER TABLE public.projects_file ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    288    287    288            �           2604    18497    projects_image id    DEFAULT     v   ALTER TABLE ONLY public.projects_image ALTER COLUMN id SET DEFAULT nextval('public.projects_image_id_seq'::regclass);
 @   ALTER TABLE public.projects_image ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    286    285    286            �           2604    18486    projects_module id    DEFAULT     x   ALTER TABLE ONLY public.projects_module ALTER COLUMN id SET DEFAULT nextval('public.projects_module_id_seq'::regclass);
 A   ALTER TABLE public.projects_module ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    283    284    284            �           2604    18533    projects_producer id    DEFAULT     |   ALTER TABLE ONLY public.projects_producer ALTER COLUMN id SET DEFAULT nextval('public.projects_producer_id_seq'::regclass);
 C   ALTER TABLE public.projects_producer ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    294    293    294            �           2604    18473    projects_project id    DEFAULT     z   ALTER TABLE ONLY public.projects_project ALTER COLUMN id SET DEFAULT nextval('public.projects_project_id_seq'::regclass);
 B   ALTER TABLE public.projects_project ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    281    282    282            �           2604    18551    projects_projectrespond id    DEFAULT     �   ALTER TABLE ONLY public.projects_projectrespond ALTER COLUMN id SET DEFAULT nextval('public.projects_projectrespond_id_seq'::regclass);
 I   ALTER TABLE public.projects_projectrespond ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    297    298    298            �           2604    18462    projects_text id    DEFAULT     t   ALTER TABLE ONLY public.projects_text ALTER COLUMN id SET DEFAULT nextval('public.projects_text_id_seq'::regclass);
 ?   ALTER TABLE public.projects_text ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    279    280    280            �           2604    18707    projects_typeofwork id    DEFAULT     �   ALTER TABLE ONLY public.projects_typeofwork ALTER COLUMN id SET DEFAULT nextval('public.projects_typeofwork_id_seq'::regclass);
 E   ALTER TABLE public.projects_typeofwork ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    302    301    302            �           2604    18440    projects_video id    DEFAULT     v   ALTER TABLE ONLY public.projects_video ALTER COLUMN id SET DEFAULT nextval('public.projects_video_id_seq'::regclass);
 @   ALTER TABLE public.projects_video ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    278    277    278            �           2604    18087    shops_category id    DEFAULT     v   ALTER TABLE ONLY public.shops_category ALTER COLUMN id SET DEFAULT nextval('public.shops_category_id_seq'::regclass);
 @   ALTER TABLE public.shops_category ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    246    247    247            �           2604    18197    shops_file id    DEFAULT     n   ALTER TABLE ONLY public.shops_file ALTER COLUMN id SET DEFAULT nextval('public.shops_file_id_seq'::regclass);
 <   ALTER TABLE public.shops_file ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    265    266    266            �           2604    18189    shops_image id    DEFAULT     p   ALTER TABLE ONLY public.shops_image ALTER COLUMN id SET DEFAULT nextval('public.shops_image_id_seq'::regclass);
 =   ALTER TABLE public.shops_image ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    263    264    264            �           2604    18132    shops_product id    DEFAULT     t   ALTER TABLE ONLY public.shops_product ALTER COLUMN id SET DEFAULT nextval('public.shops_product_id_seq'::regclass);
 ?   ALTER TABLE public.shops_product ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    254    255    255            �           2604    18205    shops_productcontent id    DEFAULT     �   ALTER TABLE ONLY public.shops_productcontent ALTER COLUMN id SET DEFAULT nextval('public.shops_productcontent_id_seq'::regclass);
 F   ALTER TABLE public.shops_productcontent ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    267    268    268            �           2604    18163    shops_productgalary id    DEFAULT     �   ALTER TABLE ONLY public.shops_productgalary ALTER COLUMN id SET DEFAULT nextval('public.shops_productgalary_id_seq'::regclass);
 E   ALTER TABLE public.shops_productgalary ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    258    259    259            �           2604    18148    shops_service id    DEFAULT     t   ALTER TABLE ONLY public.shops_service ALTER COLUMN id SET DEFAULT nextval('public.shops_service_id_seq'::regclass);
 ?   ALTER TABLE public.shops_service ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    257    256    257            �           2604    18124    shops_servicetype id    DEFAULT     |   ALTER TABLE ONLY public.shops_servicetype ALTER COLUMN id SET DEFAULT nextval('public.shops_servicetype_id_seq'::regclass);
 C   ALTER TABLE public.shops_servicetype ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    252    253    253            �           2604    18101    shops_shop id    DEFAULT     n   ALTER TABLE ONLY public.shops_shop ALTER COLUMN id SET DEFAULT nextval('public.shops_shop_id_seq'::regclass);
 <   ALTER TABLE public.shops_shop ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    249    248    249            �           2604    18116    shops_shop_employes id    DEFAULT     �   ALTER TABLE ONLY public.shops_shop_employes ALTER COLUMN id SET DEFAULT nextval('public.shops_shop_employes_id_seq'::regclass);
 E   ALTER TABLE public.shops_shop_employes ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    251    250    251            �           2604    18178    shops_text id    DEFAULT     n   ALTER TABLE ONLY public.shops_text ALTER COLUMN id SET DEFAULT nextval('public.shops_text_id_seq'::regclass);
 <   ALTER TABLE public.shops_text ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    262    261    262            �           2604    18215    shops_wishlist id    DEFAULT     v   ALTER TABLE ONLY public.shops_wishlist ALTER COLUMN id SET DEFAULT nextval('public.shops_wishlist_id_seq'::regclass);
 @   ALTER TABLE public.shops_wishlist ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    269    270    270            �           2604    18225    shops_wishlist_products id    DEFAULT     �   ALTER TABLE ONLY public.shops_wishlist_products ALTER COLUMN id SET DEFAULT nextval('public.shops_wishlist_products_id_seq'::regclass);
 I   ALTER TABLE public.shops_wishlist_products ALTER COLUMN id DROP DEFAULT;
       public       	   mplace_db    false    272    271    272            �          0    17881    account_contact 
   TABLE DATA           P   COPY public.account_contact (id, created, user_from_id, user_to_id) FROM stdin;
    public       	   mplace_db    false    231   1      �          0    17889    account_dialogs 
   TABLE DATA           P   COPY public.account_dialogs (id, room_id, user_from_id, user_to_id) FROM stdin;
    public       	   mplace_db    false    233   N      �          0    17862    account_profession 
   TABLE DATA           O   COPY public.account_profession (id, title, slug, url, description) FROM stdin;
    public       	   mplace_db    false    227   k      �          0    17852    account_profile 
   TABLE DATA           L   COPY public.account_profile (id, date_of_birth, photo, user_id) FROM stdin;
    public       	   mplace_db    false    225   �      �          0    17873    account_profiletoprofession 
   TABLE DATA           g   COPY public.account_profiletoprofession (id, confirmed, profession_id, worker_id, created) FROM stdin;
    public       	   mplace_db    false    229   �      �          0    17948    actions_action 
   TABLE DATA           c   COPY public.actions_action (id, verb, target_id, created, target_ct_id, user_id, type) FROM stdin;
    public       	   mplace_db    false    235   �      �          0    17679 
   auth_group 
   TABLE DATA           .   COPY public.auth_group (id, name) FROM stdin;
    public       	   mplace_db    false    207         �          0    17689    auth_group_permissions 
   TABLE DATA           M   COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
    public       	   mplace_db    false    209   "      �          0    17671    auth_permission 
   TABLE DATA           N   COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
    public       	   mplace_db    false    205   ?      �          0    17697 	   auth_user 
   TABLE DATA           �   COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
    public       	   mplace_db    false    211   \      �          0    17707    auth_user_groups 
   TABLE DATA           A   COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
    public       	   mplace_db    false    213         �          0    17715    auth_user_user_permissions 
   TABLE DATA           P   COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
    public       	   mplace_db    false    215   +      �          0    17791    chat_chatmessage 
   TABLE DATA           [   COPY public.chat_chatmessage (id, message, created, updated, chat_id, user_id) FROM stdin;
    public       	   mplace_db    false    221   H      �          0    17802    chat_chatmessagepack 
   TABLE DATA           W   COPY public.chat_chatmessagepack (id, pack, created, chat_id, previous_id) FROM stdin;
    public       	   mplace_db    false    223   e      �          0    17775 	   chat_room 
   TABLE DATA           :   COPY public.chat_room (id, title, staff_only) FROM stdin;
    public       	   mplace_db    false    217   �      �          0    17783    chat_room_members 
   TABLE DATA           A   COPY public.chat_room_members (id, room_id, user_id) FROM stdin;
    public       	   mplace_db    false    219   �      �          0    18005    coupons_coupon 
   TABLE DATA           Z   COPY public.coupons_coupon (id, code, valid_from, valid_to, discount, active) FROM stdin;
    public       	   mplace_db    false    239   �      �          0    17972    django_admin_log 
   TABLE DATA           �   COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
    public       	   mplace_db    false    237   �      �          0    17661    django_content_type 
   TABLE DATA           C   COPY public.django_content_type (id, app_label, model) FROM stdin;
    public       	   mplace_db    false    203   F      ~          0    17650    django_migrations 
   TABLE DATA           C   COPY public.django_migrations (id, app, name, applied) FROM stdin;
    public       	   mplace_db    false    201   v      �          0    18667    django_session 
   TABLE DATA           P   COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
    public       	   mplace_db    false    299   <      �          0    18064    images_galary 
   TABLE DATA           J   COPY public.images_galary (id, created, title, slug, user_id) FROM stdin;
    public       	   mplace_db    false    245   �      �          0    18016    images_image 
   TABLE DATA           z   COPY public.images_image (id, title, slug, url, image, description, created, user_id, total_likes, is_public) FROM stdin;
    public       	   mplace_db    false    241   �      �          0    18027    images_image_users_like 
   TABLE DATA           H   COPY public.images_image_users_like (id, image_id, user_id) FROM stdin;
    public       	   mplace_db    false    243   �      �          0    18387    orders_order 
   TABLE DATA           �   COPY public.orders_order (id, last_name, first_name, patronymic, email, address, postal_code, city, created, updated, paid, user_id, payment_id, coupon_id, discount) FROM stdin;
    public       	   mplace_db    false    274         �          0    18398    orders_orderitem 
   TABLE DATA           ^   COPY public.orders_orderitem (id, price, quantity, order_id, product_id, shop_id) FROM stdin;
    public       	   mplace_db    false    276   6      �          0    18519    projects_benchmark 
   TABLE DATA           a   COPY public.projects_benchmark (id, title, description, status, deadline, module_id) FROM stdin;
    public       	   mplace_db    false    292   S      �          0    18510    projects_content 
   TABLE DATA           U   COPY public.projects_content (id, object_id, content_type_id, module_id) FROM stdin;
    public       	   mplace_db    false    290   p      �          0    18540    projects_family 
   TABLE DATA           G   COPY public.projects_family (id, childrens_id, parents_id) FROM stdin;
    public       	   mplace_db    false    296   �      �          0    18502    projects_file 
   TABLE DATA           W   COPY public.projects_file (id, title, created, updated, file, producer_id) FROM stdin;
    public       	   mplace_db    false    288   �      �          0    18494    projects_image 
   TABLE DATA           Y   COPY public.projects_image (id, title, created, updated, image, producer_id) FROM stdin;
    public       	   mplace_db    false    286   �      �          0    18483    projects_module 
   TABLE DATA           t   COPY public.projects_module (id, title, description, complited, project_id, producer_id, profession_id) FROM stdin;
    public       	   mplace_db    false    284   �      �          0    18530    projects_producer 
   TABLE DATA           B   COPY public.projects_producer (id, take, producer_id) FROM stdin;
    public       	   mplace_db    false    294         �          0    18470    projects_project 
   TABLE DATA           r   COPY public.projects_project (id, title, slug, description, created, complited, customer_id, type_id) FROM stdin;
    public       	   mplace_db    false    282         �          0    18548    projects_projectrespond 
   TABLE DATA           s   COPY public.projects_projectrespond (id, cost, description, garanty, created, module_id, responded_id) FROM stdin;
    public       	   mplace_db    false    298   ;      �          0    18459    projects_text 
   TABLE DATA           Z   COPY public.projects_text (id, title, created, updated, content, producer_id) FROM stdin;
    public       	   mplace_db    false    280   X      �          0    18704    projects_typeofwork 
   TABLE DATA           d   COPY public.projects_typeofwork (id, title, slug, lft, rght, tree_id, level, parent_id) FROM stdin;
    public       	   mplace_db    false    302   u      �          0    18437    projects_video 
   TABLE DATA           W   COPY public.projects_video (id, title, created, updated, url, producer_id) FROM stdin;
    public       	   mplace_db    false    278   �      �          0    18084    shops_category 
   TABLE DATA           ^   COPY public.shops_category (id, name, slug, lft, rght, tree_id, level, parent_id) FROM stdin;
    public       	   mplace_db    false    247   �      �          0    18194 
   shops_file 
   TABLE DATA           a   COPY public.shops_file (id, title, created, updated, file, product_id, publisher_id) FROM stdin;
    public       	   mplace_db    false    266   �      �          0    18186    shops_image 
   TABLE DATA           c   COPY public.shops_image (id, title, created, updated, image, product_id, publisher_id) FROM stdin;
    public       	   mplace_db    false    264   �      �          0    18129    shops_product 
   TABLE DATA           �   COPY public.shops_product (id, title, slug, short_description, description, information, price, county, available, created, updated, category_id, shop_id, service_type_id) FROM stdin;
    public       	   mplace_db    false    255         �          0    18202    shops_productcontent 
   TABLE DATA           c   COPY public.shops_productcontent (id, object_id, "order", content_type_id, product_id) FROM stdin;
    public       	   mplace_db    false    268   #      �          0    18160    shops_productgalary 
   TABLE DATA           I   COPY public.shops_productgalary (id, main_image, service_id) FROM stdin;
    public       	   mplace_db    false    259   @      �          0    18168    shops_productimage 
   TABLE DATA           N   COPY public.shops_productimage (image_ptr_id, is_main, galary_id) FROM stdin;
    public       	   mplace_db    false    260   ]      �          0    18145    shops_service 
   TABLE DATA           �   COPY public.shops_service (id, title, slug, short_description, description, information, available, created, updated, category_id, shop_id, service_type_id) FROM stdin;
    public       	   mplace_db    false    257   z      �          0    18121    shops_servicetype 
   TABLE DATA           /   COPY public.shops_servicetype (id) FROM stdin;
    public       	   mplace_db    false    253   �      �          0    18098 
   shops_shop 
   TABLE DATA           t   COPY public.shops_shop (id, name, slug, title, contact_email, contact_phone, template_prefix, owner_id) FROM stdin;
    public       	   mplace_db    false    249   �      �          0    18113    shops_shop_employes 
   TABLE DATA           C   COPY public.shops_shop_employes (id, shop_id, user_id) FROM stdin;
    public       	   mplace_db    false    251   �      �          0    18175 
   shops_text 
   TABLE DATA           a   COPY public.shops_text (id, title, created, updated, text, product_id, publisher_id) FROM stdin;
    public       	   mplace_db    false    262   �      �          0    18212    shops_wishlist 
   TABLE DATA           6   COPY public.shops_wishlist (id, owner_id) FROM stdin;
    public       	   mplace_db    false    270         �          0    18222    shops_wishlist_products 
   TABLE DATA           R   COPY public.shops_wishlist_products (id, wishlist_id, servicetype_id) FROM stdin;
    public       	   mplace_db    false    272   (      �          0    18692    thumbnail_kvstore 
   TABLE DATA           7   COPY public.thumbnail_kvstore (key, value) FROM stdin;
    public       	   mplace_db    false    300   E                 0    0    account_contact_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.account_contact_id_seq', 1, false);
          public       	   mplace_db    false    230                       0    0    account_dialogs_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.account_dialogs_id_seq', 1, false);
          public       	   mplace_db    false    232                       0    0    account_profession_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.account_profession_id_seq', 1, false);
          public       	   mplace_db    false    226                       0    0    account_profile_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.account_profile_id_seq', 1, true);
          public       	   mplace_db    false    224                        0    0 "   account_profiletoprofession_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.account_profiletoprofession_id_seq', 1, false);
          public       	   mplace_db    false    228            !           0    0    actions_action_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.actions_action_id_seq', 1, false);
          public       	   mplace_db    false    234            "           0    0    auth_group_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);
          public       	   mplace_db    false    206            #           0    0    auth_group_permissions_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 77, true);
          public       	   mplace_db    false    208            $           0    0    auth_permission_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.auth_permission_id_seq', 180, true);
          public       	   mplace_db    false    204            %           0    0    auth_user_groups_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 2, true);
          public       	   mplace_db    false    212            &           0    0    auth_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);
          public       	   mplace_db    false    210            '           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);
          public       	   mplace_db    false    214            (           0    0    chat_chatmessage_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.chat_chatmessage_id_seq', 1, false);
          public       	   mplace_db    false    220            )           0    0    chat_chatmessagepack_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.chat_chatmessagepack_id_seq', 1, false);
          public       	   mplace_db    false    222            *           0    0    chat_room_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.chat_room_id_seq', 1, false);
          public       	   mplace_db    false    216            +           0    0    chat_room_members_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.chat_room_members_id_seq', 1, false);
          public       	   mplace_db    false    218            ,           0    0    coupons_coupon_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.coupons_coupon_id_seq', 1, false);
          public       	   mplace_db    false    238            -           0    0    django_admin_log_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, true);
          public       	   mplace_db    false    236            .           0    0    django_content_type_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.django_content_type_id_seq', 46, true);
          public       	   mplace_db    false    202            /           0    0    django_migrations_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.django_migrations_id_seq', 115, true);
          public       	   mplace_db    false    200            0           0    0    images_galary_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.images_galary_id_seq', 1, false);
          public       	   mplace_db    false    244            1           0    0    images_image_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.images_image_id_seq', 1, false);
          public       	   mplace_db    false    240            2           0    0    images_image_users_like_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.images_image_users_like_id_seq', 12, true);
          public       	   mplace_db    false    242            3           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);
          public       	   mplace_db    false    273            4           0    0    orders_orderitem_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.orders_orderitem_id_seq', 1, false);
          public       	   mplace_db    false    275            5           0    0    projects_benchmark_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.projects_benchmark_id_seq', 1, false);
          public       	   mplace_db    false    291            6           0    0    projects_content_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.projects_content_id_seq', 1, false);
          public       	   mplace_db    false    289            7           0    0    projects_family_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.projects_family_id_seq', 1, false);
          public       	   mplace_db    false    295            8           0    0    projects_file_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.projects_file_id_seq', 1, false);
          public       	   mplace_db    false    287            9           0    0    projects_image_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.projects_image_id_seq', 1, false);
          public       	   mplace_db    false    285            :           0    0    projects_module_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.projects_module_id_seq', 1, false);
          public       	   mplace_db    false    283            ;           0    0    projects_producer_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.projects_producer_id_seq', 1, false);
          public       	   mplace_db    false    293            <           0    0    projects_project_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.projects_project_id_seq', 1, false);
          public       	   mplace_db    false    281            =           0    0    projects_projectrespond_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.projects_projectrespond_id_seq', 1, false);
          public       	   mplace_db    false    297            >           0    0    projects_text_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.projects_text_id_seq', 1, false);
          public       	   mplace_db    false    279            ?           0    0    projects_typeofwork_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.projects_typeofwork_id_seq', 1, false);
          public       	   mplace_db    false    301            @           0    0    projects_video_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.projects_video_id_seq', 1, false);
          public       	   mplace_db    false    277            A           0    0    shops_category_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.shops_category_id_seq', 1, false);
          public       	   mplace_db    false    246            B           0    0    shops_file_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.shops_file_id_seq', 1, false);
          public       	   mplace_db    false    265            C           0    0    shops_image_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.shops_image_id_seq', 1, false);
          public       	   mplace_db    false    263            D           0    0    shops_product_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.shops_product_id_seq', 1, false);
          public       	   mplace_db    false    254            E           0    0    shops_productcontent_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.shops_productcontent_id_seq', 1, false);
          public       	   mplace_db    false    267            F           0    0    shops_productgalary_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.shops_productgalary_id_seq', 1, false);
          public       	   mplace_db    false    258            G           0    0    shops_service_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.shops_service_id_seq', 1, false);
          public       	   mplace_db    false    256            H           0    0    shops_servicetype_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.shops_servicetype_id_seq', 1, false);
          public       	   mplace_db    false    252            I           0    0    shops_shop_employes_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.shops_shop_employes_id_seq', 5, true);
          public       	   mplace_db    false    250            J           0    0    shops_shop_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.shops_shop_id_seq', 1, false);
          public       	   mplace_db    false    248            K           0    0    shops_text_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.shops_text_id_seq', 1, false);
          public       	   mplace_db    false    261            L           0    0    shops_wishlist_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.shops_wishlist_id_seq', 1, false);
          public       	   mplace_db    false    269            M           0    0    shops_wishlist_products_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.shops_wishlist_products_id_seq', 1, false);
          public       	   mplace_db    false    271            �           2606    17886 $   account_contact account_contact_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.account_contact
    ADD CONSTRAINT account_contact_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.account_contact DROP CONSTRAINT account_contact_pkey;
       public         	   mplace_db    false    231            �           2606    17894 $   account_dialogs account_dialogs_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.account_dialogs
    ADD CONSTRAINT account_dialogs_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.account_dialogs DROP CONSTRAINT account_dialogs_pkey;
       public         	   mplace_db    false    233            �           2606    17870 *   account_profession account_profession_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.account_profession
    ADD CONSTRAINT account_profession_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.account_profession DROP CONSTRAINT account_profession_pkey;
       public         	   mplace_db    false    227            �           2606    17857 $   account_profile account_profile_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.account_profile
    ADD CONSTRAINT account_profile_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.account_profile DROP CONSTRAINT account_profile_pkey;
       public         	   mplace_db    false    225            �           2606    17859 +   account_profile account_profile_user_id_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.account_profile
    ADD CONSTRAINT account_profile_user_id_key UNIQUE (user_id);
 U   ALTER TABLE ONLY public.account_profile DROP CONSTRAINT account_profile_user_id_key;
       public         	   mplace_db    false    225            �           2606    17878 <   account_profiletoprofession account_profiletoprofession_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.account_profiletoprofession
    ADD CONSTRAINT account_profiletoprofession_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.account_profiletoprofession DROP CONSTRAINT account_profiletoprofession_pkey;
       public         	   mplace_db    false    229            �           2606    17954 "   actions_action actions_action_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.actions_action
    ADD CONSTRAINT actions_action_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.actions_action DROP CONSTRAINT actions_action_pkey;
       public         	   mplace_db    false    235            �           2606    18001    auth_group auth_group_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public         	   mplace_db    false    207            �           2606    17741 R   auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);
 |   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
       public         	   mplace_db    false    209    209            �           2606    17694 2   auth_group_permissions auth_group_permissions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public         	   mplace_db    false    209            �           2606    17684    auth_group auth_group_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public         	   mplace_db    false    207            �           2606    17727 F   auth_permission auth_permission_content_type_id_codename_01ab375a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);
 p   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
       public         	   mplace_db    false    205    205            �           2606    17676 $   auth_permission auth_permission_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public         	   mplace_db    false    205            �           2606    17712 &   auth_user_groups auth_user_groups_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
       public         	   mplace_db    false    213            �           2606    17756 @   auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);
 j   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq;
       public         	   mplace_db    false    213    213            �           2606    17702    auth_user auth_user_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
       public         	   mplace_db    false    211            �           2606    17720 :   auth_user_user_permissions auth_user_user_permissions_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
       public         	   mplace_db    false    215            �           2606    17770 Y   auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
       public         	   mplace_db    false    215    215            �           2606    17995     auth_user auth_user_username_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);
 J   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
       public         	   mplace_db    false    211            �           2606    17799 &   chat_chatmessage chat_chatmessage_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.chat_chatmessage
    ADD CONSTRAINT chat_chatmessage_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.chat_chatmessage DROP CONSTRAINT chat_chatmessage_pkey;
       public         	   mplace_db    false    221            �           2606    17810 .   chat_chatmessagepack chat_chatmessagepack_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.chat_chatmessagepack
    ADD CONSTRAINT chat_chatmessagepack_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.chat_chatmessagepack DROP CONSTRAINT chat_chatmessagepack_pkey;
       public         	   mplace_db    false    223            �           2606    17812 9   chat_chatmessagepack chat_chatmessagepack_previous_id_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.chat_chatmessagepack
    ADD CONSTRAINT chat_chatmessagepack_previous_id_key UNIQUE (previous_id);
 c   ALTER TABLE ONLY public.chat_chatmessagepack DROP CONSTRAINT chat_chatmessagepack_previous_id_key;
       public         	   mplace_db    false    223            �           2606    17788 (   chat_room_members chat_room_members_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.chat_room_members
    ADD CONSTRAINT chat_room_members_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.chat_room_members DROP CONSTRAINT chat_room_members_pkey;
       public         	   mplace_db    false    219            �           2606    17824 A   chat_room_members chat_room_members_room_id_user_id_757937a9_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.chat_room_members
    ADD CONSTRAINT chat_room_members_room_id_user_id_757937a9_uniq UNIQUE (room_id, user_id);
 k   ALTER TABLE ONLY public.chat_room_members DROP CONSTRAINT chat_room_members_room_id_user_id_757937a9_uniq;
       public         	   mplace_db    false    219    219            �           2606    17780    chat_room chat_room_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.chat_room
    ADD CONSTRAINT chat_room_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.chat_room DROP CONSTRAINT chat_room_pkey;
       public         	   mplace_db    false    217                       2606    18012 &   coupons_coupon coupons_coupon_code_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.coupons_coupon
    ADD CONSTRAINT coupons_coupon_code_key UNIQUE (code);
 P   ALTER TABLE ONLY public.coupons_coupon DROP CONSTRAINT coupons_coupon_code_key;
       public         	   mplace_db    false    239                       2606    18010 "   coupons_coupon coupons_coupon_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.coupons_coupon
    ADD CONSTRAINT coupons_coupon_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.coupons_coupon DROP CONSTRAINT coupons_coupon_pkey;
       public         	   mplace_db    false    239                        2606    17981 &   django_admin_log django_admin_log_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public         	   mplace_db    false    237            �           2606    17668 E   django_content_type django_content_type_app_label_model_76bd3d3b_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);
 o   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
       public         	   mplace_db    false    203    203            �           2606    17666 ,   django_content_type django_content_type_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public         	   mplace_db    false    203            �           2606    17658 (   django_migrations django_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public         	   mplace_db    false    201            �           2606    18674 "   django_session django_session_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public         	   mplace_db    false    299                       2606    18069     images_galary images_galary_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.images_galary
    ADD CONSTRAINT images_galary_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.images_galary DROP CONSTRAINT images_galary_pkey;
       public         	   mplace_db    false    245            	           2606    18024    images_image images_image_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.images_image
    ADD CONSTRAINT images_image_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.images_image DROP CONSTRAINT images_image_pkey;
       public         	   mplace_db    false    241                       2606    18053 N   images_image_users_like images_image_users_like_image_id_user_id_ec4f7c0f_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.images_image_users_like
    ADD CONSTRAINT images_image_users_like_image_id_user_id_ec4f7c0f_uniq UNIQUE (image_id, user_id);
 x   ALTER TABLE ONLY public.images_image_users_like DROP CONSTRAINT images_image_users_like_image_id_user_id_ec4f7c0f_uniq;
       public         	   mplace_db    false    243    243                       2606    18032 4   images_image_users_like images_image_users_like_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.images_image_users_like
    ADD CONSTRAINT images_image_users_like_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.images_image_users_like DROP CONSTRAINT images_image_users_like_pkey;
       public         	   mplace_db    false    243            o           2606    18395    orders_order orders_order_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.orders_order DROP CONSTRAINT orders_order_pkey;
       public         	   mplace_db    false    274            s           2606    18404 &   orders_orderitem orders_orderitem_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.orders_orderitem DROP CONSTRAINT orders_orderitem_pkey;
       public         	   mplace_db    false    276            �           2606    18527 *   projects_benchmark projects_benchmark_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.projects_benchmark
    ADD CONSTRAINT projects_benchmark_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.projects_benchmark DROP CONSTRAINT projects_benchmark_pkey;
       public         	   mplace_db    false    292            �           2606    18516 &   projects_content projects_content_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.projects_content
    ADD CONSTRAINT projects_content_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.projects_content DROP CONSTRAINT projects_content_pkey;
       public         	   mplace_db    false    290            �           2606    18545 $   projects_family projects_family_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.projects_family
    ADD CONSTRAINT projects_family_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.projects_family DROP CONSTRAINT projects_family_pkey;
       public         	   mplace_db    false    296            �           2606    18507     projects_file projects_file_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.projects_file
    ADD CONSTRAINT projects_file_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.projects_file DROP CONSTRAINT projects_file_pkey;
       public         	   mplace_db    false    288            �           2606    18499 "   projects_image projects_image_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.projects_image
    ADD CONSTRAINT projects_image_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.projects_image DROP CONSTRAINT projects_image_pkey;
       public         	   mplace_db    false    286            �           2606    18491 $   projects_module projects_module_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.projects_module
    ADD CONSTRAINT projects_module_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.projects_module DROP CONSTRAINT projects_module_pkey;
       public         	   mplace_db    false    284            �           2606    18537 /   projects_module projects_module_producer_id_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.projects_module
    ADD CONSTRAINT projects_module_producer_id_key UNIQUE (producer_id);
 Y   ALTER TABLE ONLY public.projects_module DROP CONSTRAINT projects_module_producer_id_key;
       public         	   mplace_db    false    284            �           2606    18535 (   projects_producer projects_producer_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.projects_producer
    ADD CONSTRAINT projects_producer_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.projects_producer DROP CONSTRAINT projects_producer_pkey;
       public         	   mplace_db    false    294            ~           2606    18478 &   projects_project projects_project_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.projects_project
    ADD CONSTRAINT projects_project_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.projects_project DROP CONSTRAINT projects_project_pkey;
       public         	   mplace_db    false    282            �           2606    18480 *   projects_project projects_project_slug_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.projects_project
    ADD CONSTRAINT projects_project_slug_key UNIQUE (slug);
 T   ALTER TABLE ONLY public.projects_project DROP CONSTRAINT projects_project_slug_key;
       public         	   mplace_db    false    282            �           2606    18556 4   projects_projectrespond projects_projectrespond_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.projects_projectrespond
    ADD CONSTRAINT projects_projectrespond_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.projects_projectrespond DROP CONSTRAINT projects_projectrespond_pkey;
       public         	   mplace_db    false    298            z           2606    18467     projects_text projects_text_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.projects_text
    ADD CONSTRAINT projects_text_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.projects_text DROP CONSTRAINT projects_text_pkey;
       public         	   mplace_db    false    280            �           2606    18713 ,   projects_typeofwork projects_typeofwork_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.projects_typeofwork
    ADD CONSTRAINT projects_typeofwork_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.projects_typeofwork DROP CONSTRAINT projects_typeofwork_pkey;
       public         	   mplace_db    false    302            �           2606    18715 0   projects_typeofwork projects_typeofwork_slug_key 
   CONSTRAINT     k   ALTER TABLE ONLY public.projects_typeofwork
    ADD CONSTRAINT projects_typeofwork_slug_key UNIQUE (slug);
 Z   ALTER TABLE ONLY public.projects_typeofwork DROP CONSTRAINT projects_typeofwork_slug_key;
       public         	   mplace_db    false    302            w           2606    18442 "   projects_video projects_video_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.projects_video
    ADD CONSTRAINT projects_video_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.projects_video DROP CONSTRAINT projects_video_pkey;
       public         	   mplace_db    false    278                       2606    18093 "   shops_category shops_category_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.shops_category
    ADD CONSTRAINT shops_category_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.shops_category DROP CONSTRAINT shops_category_pkey;
       public         	   mplace_db    false    247            !           2606    18095 &   shops_category shops_category_slug_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shops_category
    ADD CONSTRAINT shops_category_slug_key UNIQUE (slug);
 P   ALTER TABLE ONLY public.shops_category DROP CONSTRAINT shops_category_slug_key;
       public         	   mplace_db    false    247            \           2606    18199    shops_file shops_file_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.shops_file
    ADD CONSTRAINT shops_file_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.shops_file DROP CONSTRAINT shops_file_pkey;
       public         	   mplace_db    false    266            X           2606    18191    shops_image shops_image_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.shops_image
    ADD CONSTRAINT shops_image_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.shops_image DROP CONSTRAINT shops_image_pkey;
       public         	   mplace_db    false    264            7           2606    18138     shops_product shops_product_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shops_product
    ADD CONSTRAINT shops_product_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shops_product DROP CONSTRAINT shops_product_pkey;
       public         	   mplace_db    false    255            9           2606    18142 /   shops_product shops_product_service_type_id_key 
   CONSTRAINT     u   ALTER TABLE ONLY public.shops_product
    ADD CONSTRAINT shops_product_service_type_id_key UNIQUE (service_type_id);
 Y   ALTER TABLE ONLY public.shops_product DROP CONSTRAINT shops_product_service_type_id_key;
       public         	   mplace_db    false    255            =           2606    18140 $   shops_product shops_product_slug_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.shops_product
    ADD CONSTRAINT shops_product_slug_key UNIQUE (slug);
 N   ALTER TABLE ONLY public.shops_product DROP CONSTRAINT shops_product_slug_key;
       public         	   mplace_db    false    255            a           2606    18209 .   shops_productcontent shops_productcontent_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.shops_productcontent
    ADD CONSTRAINT shops_productcontent_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.shops_productcontent DROP CONSTRAINT shops_productcontent_pkey;
       public         	   mplace_db    false    268            M           2606    18165 ,   shops_productgalary shops_productgalary_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.shops_productgalary
    ADD CONSTRAINT shops_productgalary_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.shops_productgalary DROP CONSTRAINT shops_productgalary_pkey;
       public         	   mplace_db    false    259            O           2606    18167 6   shops_productgalary shops_productgalary_service_id_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.shops_productgalary
    ADD CONSTRAINT shops_productgalary_service_id_key UNIQUE (service_id);
 `   ALTER TABLE ONLY public.shops_productgalary DROP CONSTRAINT shops_productgalary_service_id_key;
       public         	   mplace_db    false    259            R           2606    18172 *   shops_productimage shops_productimage_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.shops_productimage
    ADD CONSTRAINT shops_productimage_pkey PRIMARY KEY (image_ptr_id);
 T   ALTER TABLE ONLY public.shops_productimage DROP CONSTRAINT shops_productimage_pkey;
       public         	   mplace_db    false    260            C           2606    18153     shops_service shops_service_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shops_service
    ADD CONSTRAINT shops_service_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shops_service DROP CONSTRAINT shops_service_pkey;
       public         	   mplace_db    false    257            E           2606    18157 /   shops_service shops_service_service_type_id_key 
   CONSTRAINT     u   ALTER TABLE ONLY public.shops_service
    ADD CONSTRAINT shops_service_service_type_id_key UNIQUE (service_type_id);
 Y   ALTER TABLE ONLY public.shops_service DROP CONSTRAINT shops_service_service_type_id_key;
       public         	   mplace_db    false    257            I           2606    18155 $   shops_service shops_service_slug_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.shops_service
    ADD CONSTRAINT shops_service_slug_key UNIQUE (slug);
 N   ALTER TABLE ONLY public.shops_service DROP CONSTRAINT shops_service_slug_key;
       public         	   mplace_db    false    257            3           2606    18126 (   shops_servicetype shops_servicetype_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.shops_servicetype
    ADD CONSTRAINT shops_servicetype_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.shops_servicetype DROP CONSTRAINT shops_servicetype_pkey;
       public         	   mplace_db    false    253            -           2606    18118 ,   shops_shop_employes shops_shop_employes_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.shops_shop_employes
    ADD CONSTRAINT shops_shop_employes_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.shops_shop_employes DROP CONSTRAINT shops_shop_employes_pkey;
       public         	   mplace_db    false    251            0           2606    18257 E   shops_shop_employes shops_shop_employes_shop_id_user_id_d416d0cd_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.shops_shop_employes
    ADD CONSTRAINT shops_shop_employes_shop_id_user_id_d416d0cd_uniq UNIQUE (shop_id, user_id);
 o   ALTER TABLE ONLY public.shops_shop_employes DROP CONSTRAINT shops_shop_employes_shop_id_user_id_d416d0cd_uniq;
       public         	   mplace_db    false    251    251            %           2606    18106    shops_shop shops_shop_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.shops_shop
    ADD CONSTRAINT shops_shop_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.shops_shop DROP CONSTRAINT shops_shop_pkey;
       public         	   mplace_db    false    249            (           2606    18108    shops_shop shops_shop_slug_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.shops_shop
    ADD CONSTRAINT shops_shop_slug_key UNIQUE (slug);
 H   ALTER TABLE ONLY public.shops_shop DROP CONSTRAINT shops_shop_slug_key;
       public         	   mplace_db    false    249            +           2606    18110 )   shops_shop shops_shop_template_prefix_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.shops_shop
    ADD CONSTRAINT shops_shop_template_prefix_key UNIQUE (template_prefix);
 S   ALTER TABLE ONLY public.shops_shop DROP CONSTRAINT shops_shop_template_prefix_key;
       public         	   mplace_db    false    249            T           2606    18183    shops_text shops_text_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.shops_text
    ADD CONSTRAINT shops_text_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.shops_text DROP CONSTRAINT shops_text_pkey;
       public         	   mplace_db    false    262            d           2606    18219 *   shops_wishlist shops_wishlist_owner_id_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.shops_wishlist
    ADD CONSTRAINT shops_wishlist_owner_id_key UNIQUE (owner_id);
 T   ALTER TABLE ONLY public.shops_wishlist DROP CONSTRAINT shops_wishlist_owner_id_key;
       public         	   mplace_db    false    270            f           2606    18217 "   shops_wishlist shops_wishlist_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.shops_wishlist
    ADD CONSTRAINT shops_wishlist_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.shops_wishlist DROP CONSTRAINT shops_wishlist_pkey;
       public         	   mplace_db    false    270            h           2606    18227 4   shops_wishlist_products shops_wishlist_products_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.shops_wishlist_products
    ADD CONSTRAINT shops_wishlist_products_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.shops_wishlist_products DROP CONSTRAINT shops_wishlist_products_pkey;
       public         	   mplace_db    false    272            l           2606    18382 V   shops_wishlist_products shops_wishlist_products_wishlist_id_servicetype__6260123b_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.shops_wishlist_products
    ADD CONSTRAINT shops_wishlist_products_wishlist_id_servicetype__6260123b_uniq UNIQUE (wishlist_id, servicetype_id);
 �   ALTER TABLE ONLY public.shops_wishlist_products DROP CONSTRAINT shops_wishlist_products_wishlist_id_servicetype__6260123b_uniq;
       public         	   mplace_db    false    272    272            �           2606    18699 (   thumbnail_kvstore thumbnail_kvstore_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.thumbnail_kvstore
    ADD CONSTRAINT thumbnail_kvstore_pkey PRIMARY KEY (key);
 R   ALTER TABLE ONLY public.thumbnail_kvstore DROP CONSTRAINT thumbnail_kvstore_pkey;
       public         	   mplace_db    false    300            �           1259    17925     account_contact_created_fd56076e    INDEX     _   CREATE INDEX account_contact_created_fd56076e ON public.account_contact USING btree (created);
 4   DROP INDEX public.account_contact_created_fd56076e;
       public         	   mplace_db    false    231            �           1259    17926 %   account_contact_user_from_id_5ac376e2    INDEX     i   CREATE INDEX account_contact_user_from_id_5ac376e2 ON public.account_contact USING btree (user_from_id);
 9   DROP INDEX public.account_contact_user_from_id_5ac376e2;
       public         	   mplace_db    false    231            �           1259    17927 #   account_contact_user_to_id_51f55e86    INDEX     e   CREATE INDEX account_contact_user_to_id_51f55e86 ON public.account_contact USING btree (user_to_id);
 7   DROP INDEX public.account_contact_user_to_id_51f55e86;
       public         	   mplace_db    false    231            �           1259    17943     account_dialogs_room_id_b972e0b6    INDEX     _   CREATE INDEX account_dialogs_room_id_b972e0b6 ON public.account_dialogs USING btree (room_id);
 4   DROP INDEX public.account_dialogs_room_id_b972e0b6;
       public         	   mplace_db    false    233            �           1259    17944 %   account_dialogs_user_from_id_4ee99014    INDEX     i   CREATE INDEX account_dialogs_user_from_id_4ee99014 ON public.account_dialogs USING btree (user_from_id);
 9   DROP INDEX public.account_dialogs_user_from_id_4ee99014;
       public         	   mplace_db    false    233            �           1259    17945 #   account_dialogs_user_to_id_50c7c3f0    INDEX     e   CREATE INDEX account_dialogs_user_to_id_50c7c3f0 ON public.account_dialogs USING btree (user_to_id);
 7   DROP INDEX public.account_dialogs_user_to_id_50c7c3f0;
       public         	   mplace_db    false    233            �           1259    17900     account_profession_slug_564649ae    INDEX     _   CREATE INDEX account_profession_slug_564649ae ON public.account_profession USING btree (slug);
 4   DROP INDEX public.account_profession_slug_564649ae;
       public         	   mplace_db    false    227            �           1259    17901 %   account_profession_slug_564649ae_like    INDEX     x   CREATE INDEX account_profession_slug_564649ae_like ON public.account_profession USING btree (slug varchar_pattern_ops);
 9   DROP INDEX public.account_profession_slug_564649ae_like;
       public         	   mplace_db    false    227            �           1259    17914 ,   account_profiletoprofession_created_c4e975c3    INDEX     w   CREATE INDEX account_profiletoprofession_created_c4e975c3 ON public.account_profiletoprofession USING btree (created);
 @   DROP INDEX public.account_profiletoprofession_created_c4e975c3;
       public         	   mplace_db    false    229            �           1259    17912 2   account_profiletoprofession_profession_id_1e3b7c90    INDEX     �   CREATE INDEX account_profiletoprofession_profession_id_1e3b7c90 ON public.account_profiletoprofession USING btree (profession_id);
 F   DROP INDEX public.account_profiletoprofession_profession_id_1e3b7c90;
       public         	   mplace_db    false    229            �           1259    17913 .   account_profiletoprofession_worker_id_0b2eb064    INDEX     {   CREATE INDEX account_profiletoprofession_worker_id_0b2eb064 ON public.account_profiletoprofession USING btree (worker_id);
 B   DROP INDEX public.account_profiletoprofession_worker_id_0b2eb064;
       public         	   mplace_db    false    229            �           1259    17966    actions_action_created_969d29e5    INDEX     ]   CREATE INDEX actions_action_created_969d29e5 ON public.actions_action USING btree (created);
 3   DROP INDEX public.actions_action_created_969d29e5;
       public         	   mplace_db    false    235            �           1259    17967 $   actions_action_target_ct_id_63e2300e    INDEX     g   CREATE INDEX actions_action_target_ct_id_63e2300e ON public.actions_action USING btree (target_ct_id);
 8   DROP INDEX public.actions_action_target_ct_id_63e2300e;
       public         	   mplace_db    false    235            �           1259    17965 !   actions_action_target_id_128ce21d    INDEX     a   CREATE INDEX actions_action_target_id_128ce21d ON public.actions_action USING btree (target_id);
 5   DROP INDEX public.actions_action_target_id_128ce21d;
       public         	   mplace_db    false    235            �           1259    17968    actions_action_user_id_f34f0949    INDEX     ]   CREATE INDEX actions_action_user_id_f34f0949 ON public.actions_action USING btree (user_id);
 3   DROP INDEX public.actions_action_user_id_f34f0949;
       public         	   mplace_db    false    235            �           1259    18002    auth_group_name_a6ea08ec_like    INDEX     h   CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);
 1   DROP INDEX public.auth_group_name_a6ea08ec_like;
       public         	   mplace_db    false    207            �           1259    17742 (   auth_group_permissions_group_id_b120cbf9    INDEX     o   CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);
 <   DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
       public         	   mplace_db    false    209            �           1259    17743 -   auth_group_permissions_permission_id_84c5c92e    INDEX     y   CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);
 A   DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
       public         	   mplace_db    false    209            �           1259    17728 (   auth_permission_content_type_id_2f476e4b    INDEX     o   CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);
 <   DROP INDEX public.auth_permission_content_type_id_2f476e4b;
       public         	   mplace_db    false    205            �           1259    17758 "   auth_user_groups_group_id_97559544    INDEX     c   CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);
 6   DROP INDEX public.auth_user_groups_group_id_97559544;
       public         	   mplace_db    false    213            �           1259    17757 !   auth_user_groups_user_id_6a12ed8b    INDEX     a   CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);
 5   DROP INDEX public.auth_user_groups_user_id_6a12ed8b;
       public         	   mplace_db    false    213            �           1259    17772 1   auth_user_user_permissions_permission_id_1fbb5f2c    INDEX     �   CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);
 E   DROP INDEX public.auth_user_user_permissions_permission_id_1fbb5f2c;
       public         	   mplace_db    false    215            �           1259    17771 +   auth_user_user_permissions_user_id_a95ead1b    INDEX     u   CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);
 ?   DROP INDEX public.auth_user_user_permissions_user_id_a95ead1b;
       public         	   mplace_db    false    215            �           1259    17996     auth_user_username_6821ab7c_like    INDEX     n   CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);
 4   DROP INDEX public.auth_user_username_6821ab7c_like;
       public         	   mplace_db    false    211            �           1259    17837 !   chat_chatmessage_chat_id_356f3993    INDEX     a   CREATE INDEX chat_chatmessage_chat_id_356f3993 ON public.chat_chatmessage USING btree (chat_id);
 5   DROP INDEX public.chat_chatmessage_chat_id_356f3993;
       public         	   mplace_db    false    221            �           1259    17838 !   chat_chatmessage_user_id_fa615e65    INDEX     a   CREATE INDEX chat_chatmessage_user_id_fa615e65 ON public.chat_chatmessage USING btree (user_id);
 5   DROP INDEX public.chat_chatmessage_user_id_fa615e65;
       public         	   mplace_db    false    221            �           1259    17849 %   chat_chatmessagepack_chat_id_bac9aefa    INDEX     i   CREATE INDEX chat_chatmessagepack_chat_id_bac9aefa ON public.chat_chatmessagepack USING btree (chat_id);
 9   DROP INDEX public.chat_chatmessagepack_chat_id_bac9aefa;
       public         	   mplace_db    false    223            �           1259    17825 "   chat_room_members_room_id_45721890    INDEX     c   CREATE INDEX chat_room_members_room_id_45721890 ON public.chat_room_members USING btree (room_id);
 6   DROP INDEX public.chat_room_members_room_id_45721890;
       public         	   mplace_db    false    219            �           1259    17826 "   chat_room_members_user_id_78b43a81    INDEX     c   CREATE INDEX chat_room_members_user_id_78b43a81 ON public.chat_room_members USING btree (user_id);
 6   DROP INDEX public.chat_room_members_user_id_78b43a81;
       public         	   mplace_db    false    219                       1259    18013 !   coupons_coupon_code_40174643_like    INDEX     p   CREATE INDEX coupons_coupon_code_40174643_like ON public.coupons_coupon USING btree (code varchar_pattern_ops);
 5   DROP INDEX public.coupons_coupon_code_40174643_like;
       public         	   mplace_db    false    239            �           1259    17992 )   django_admin_log_content_type_id_c4bce8eb    INDEX     q   CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
 =   DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
       public         	   mplace_db    false    237                       1259    17993 !   django_admin_log_user_id_c564eba6    INDEX     a   CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);
 5   DROP INDEX public.django_admin_log_user_id_c564eba6;
       public         	   mplace_db    false    237            �           1259    18676 #   django_session_expire_date_a5c62663    INDEX     e   CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
 7   DROP INDEX public.django_session_expire_date_a5c62663;
       public         	   mplace_db    false    299            �           1259    18675 (   django_session_session_key_c0390e0f_like    INDEX     ~   CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public         	   mplace_db    false    299                       1259    18075    images_galary_created_bb41a9ab    INDEX     [   CREATE INDEX images_galary_created_bb41a9ab ON public.images_galary USING btree (created);
 2   DROP INDEX public.images_galary_created_bb41a9ab;
       public         	   mplace_db    false    245                       1259    18076    images_galary_slug_6a18eb86    INDEX     U   CREATE INDEX images_galary_slug_6a18eb86 ON public.images_galary USING btree (slug);
 /   DROP INDEX public.images_galary_slug_6a18eb86;
       public         	   mplace_db    false    245                       1259    18077     images_galary_slug_6a18eb86_like    INDEX     n   CREATE INDEX images_galary_slug_6a18eb86_like ON public.images_galary USING btree (slug varchar_pattern_ops);
 4   DROP INDEX public.images_galary_slug_6a18eb86_like;
       public         	   mplace_db    false    245                       1259    18078    images_galary_user_id_b23face0    INDEX     [   CREATE INDEX images_galary_user_id_b23face0 ON public.images_galary USING btree (user_id);
 2   DROP INDEX public.images_galary_user_id_b23face0;
       public         	   mplace_db    false    245                       1259    18040    images_image_created_7fb4bf39    INDEX     Y   CREATE INDEX images_image_created_7fb4bf39 ON public.images_image USING btree (created);
 1   DROP INDEX public.images_image_created_7fb4bf39;
       public         	   mplace_db    false    241            
           1259    18060    images_image_slug_86cc6ded    INDEX     S   CREATE INDEX images_image_slug_86cc6ded ON public.images_image USING btree (slug);
 .   DROP INDEX public.images_image_slug_86cc6ded;
       public         	   mplace_db    false    241                       1259    18061    images_image_slug_86cc6ded_like    INDEX     l   CREATE INDEX images_image_slug_86cc6ded_like ON public.images_image USING btree (slug varchar_pattern_ops);
 3   DROP INDEX public.images_image_slug_86cc6ded_like;
       public         	   mplace_db    false    241                       1259    18058 !   images_image_total_likes_ea91e91a    INDEX     a   CREATE INDEX images_image_total_likes_ea91e91a ON public.images_image USING btree (total_likes);
 5   DROP INDEX public.images_image_total_likes_ea91e91a;
       public         	   mplace_db    false    241                       1259    18041    images_image_user_id_55499d60    INDEX     Y   CREATE INDEX images_image_user_id_55499d60 ON public.images_image USING btree (user_id);
 1   DROP INDEX public.images_image_user_id_55499d60;
       public         	   mplace_db    false    241                       1259    18054 )   images_image_users_like_image_id_8b6abde8    INDEX     q   CREATE INDEX images_image_users_like_image_id_8b6abde8 ON public.images_image_users_like USING btree (image_id);
 =   DROP INDEX public.images_image_users_like_image_id_8b6abde8;
       public         	   mplace_db    false    243                       1259    18055 (   images_image_users_like_user_id_72060bdd    INDEX     o   CREATE INDEX images_image_users_like_user_id_72060bdd ON public.images_image_users_like USING btree (user_id);
 <   DROP INDEX public.images_image_users_like_user_id_72060bdd;
       public         	   mplace_db    false    243            m           1259    18416    orders_order_coupon_id_5bddb887    INDEX     ]   CREATE INDEX orders_order_coupon_id_5bddb887 ON public.orders_order USING btree (coupon_id);
 3   DROP INDEX public.orders_order_coupon_id_5bddb887;
       public         	   mplace_db    false    274            p           1259    18415    orders_order_user_id_e9b59eb1    INDEX     Y   CREATE INDEX orders_order_user_id_e9b59eb1 ON public.orders_order USING btree (user_id);
 1   DROP INDEX public.orders_order_user_id_e9b59eb1;
       public         	   mplace_db    false    274            q           1259    18432 "   orders_orderitem_order_id_fe61a34d    INDEX     c   CREATE INDEX orders_orderitem_order_id_fe61a34d ON public.orders_orderitem USING btree (order_id);
 6   DROP INDEX public.orders_orderitem_order_id_fe61a34d;
       public         	   mplace_db    false    276            t           1259    18433 $   orders_orderitem_product_id_afe4254a    INDEX     g   CREATE INDEX orders_orderitem_product_id_afe4254a ON public.orders_orderitem USING btree (product_id);
 8   DROP INDEX public.orders_orderitem_product_id_afe4254a;
       public         	   mplace_db    false    276            u           1259    18434 !   orders_orderitem_shop_id_268d2151    INDEX     a   CREATE INDEX orders_orderitem_shop_id_268d2151 ON public.orders_orderitem USING btree (shop_id);
 5   DROP INDEX public.orders_orderitem_shop_id_268d2151;
       public         	   mplace_db    false    276            �           1259    18625 %   projects_benchmark_module_id_8db2df7b    INDEX     i   CREATE INDEX projects_benchmark_module_id_8db2df7b ON public.projects_benchmark USING btree (module_id);
 9   DROP INDEX public.projects_benchmark_module_id_8db2df7b;
       public         	   mplace_db    false    292            �           1259    18618 )   projects_content_content_type_id_eb5c5510    INDEX     q   CREATE INDEX projects_content_content_type_id_eb5c5510 ON public.projects_content USING btree (content_type_id);
 =   DROP INDEX public.projects_content_content_type_id_eb5c5510;
       public         	   mplace_db    false    290            �           1259    18619 #   projects_content_module_id_29d1cb12    INDEX     e   CREATE INDEX projects_content_module_id_29d1cb12 ON public.projects_content USING btree (module_id);
 7   DROP INDEX public.projects_content_module_id_29d1cb12;
       public         	   mplace_db    false    290            �           1259    18647 %   projects_family_childrens_id_2f260865    INDEX     i   CREATE INDEX projects_family_childrens_id_2f260865 ON public.projects_family USING btree (childrens_id);
 9   DROP INDEX public.projects_family_childrens_id_2f260865;
       public         	   mplace_db    false    296            �           1259    18648 #   projects_family_parents_id_ee858db2    INDEX     e   CREATE INDEX projects_family_parents_id_ee858db2 ON public.projects_family USING btree (parents_id);
 7   DROP INDEX public.projects_family_parents_id_ee858db2;
       public         	   mplace_db    false    296            �           1259    18607 "   projects_file_producer_id_82c18b0c    INDEX     c   CREATE INDEX projects_file_producer_id_82c18b0c ON public.projects_file USING btree (producer_id);
 6   DROP INDEX public.projects_file_producer_id_82c18b0c;
       public         	   mplace_db    false    288            �           1259    18601 #   projects_image_producer_id_7c57c72e    INDEX     e   CREATE INDEX projects_image_producer_id_7c57c72e ON public.projects_image USING btree (producer_id);
 7   DROP INDEX public.projects_image_producer_id_7c57c72e;
       public         	   mplace_db    false    286            �           1259    18649 &   projects_module_profession_id_8d10259c    INDEX     k   CREATE INDEX projects_module_profession_id_8d10259c ON public.projects_module USING btree (profession_id);
 :   DROP INDEX public.projects_module_profession_id_8d10259c;
       public         	   mplace_db    false    284            �           1259    18595 #   projects_module_project_id_5ce2732a    INDEX     e   CREATE INDEX projects_module_project_id_5ce2732a ON public.projects_module USING btree (project_id);
 7   DROP INDEX public.projects_module_project_id_5ce2732a;
       public         	   mplace_db    false    284            �           1259    18631 &   projects_producer_producer_id_1e753690    INDEX     k   CREATE INDEX projects_producer_producer_id_1e753690 ON public.projects_producer USING btree (producer_id);
 :   DROP INDEX public.projects_producer_producer_id_1e753690;
       public         	   mplace_db    false    294            |           1259    18588 %   projects_project_customer_id_731c79d1    INDEX     i   CREATE INDEX projects_project_customer_id_731c79d1 ON public.projects_project USING btree (customer_id);
 9   DROP INDEX public.projects_project_customer_id_731c79d1;
       public         	   mplace_db    false    282                       1259    18587 #   projects_project_slug_2d50067a_like    INDEX     t   CREATE INDEX projects_project_slug_2d50067a_like ON public.projects_project USING btree (slug varchar_pattern_ops);
 7   DROP INDEX public.projects_project_slug_2d50067a_like;
       public         	   mplace_db    false    282            �           1259    18724 !   projects_project_type_id_6a1aa51a    INDEX     a   CREATE INDEX projects_project_type_id_6a1aa51a ON public.projects_project USING btree (type_id);
 5   DROP INDEX public.projects_project_type_id_6a1aa51a;
       public         	   mplace_db    false    282            �           1259    18665 *   projects_projectrespond_module_id_0edd22d0    INDEX     s   CREATE INDEX projects_projectrespond_module_id_0edd22d0 ON public.projects_projectrespond USING btree (module_id);
 >   DROP INDEX public.projects_projectrespond_module_id_0edd22d0;
       public         	   mplace_db    false    298            �           1259    18666 -   projects_projectrespond_responded_id_ae590a31    INDEX     y   CREATE INDEX projects_projectrespond_responded_id_ae590a31 ON public.projects_projectrespond USING btree (responded_id);
 A   DROP INDEX public.projects_projectrespond_responded_id_ae590a31;
       public         	   mplace_db    false    298            {           1259    18576 "   projects_text_producer_id_e23c81ca    INDEX     c   CREATE INDEX projects_text_producer_id_e23c81ca ON public.projects_text USING btree (producer_id);
 6   DROP INDEX public.projects_text_producer_id_e23c81ca;
       public         	   mplace_db    false    280            �           1259    18723 &   projects_typeofwork_parent_id_5627f020    INDEX     k   CREATE INDEX projects_typeofwork_parent_id_5627f020 ON public.projects_typeofwork USING btree (parent_id);
 :   DROP INDEX public.projects_typeofwork_parent_id_5627f020;
       public         	   mplace_db    false    302            �           1259    18721 &   projects_typeofwork_slug_42fc5ee3_like    INDEX     z   CREATE INDEX projects_typeofwork_slug_42fc5ee3_like ON public.projects_typeofwork USING btree (slug varchar_pattern_ops);
 :   DROP INDEX public.projects_typeofwork_slug_42fc5ee3_like;
       public         	   mplace_db    false    302            �           1259    18722 $   projects_typeofwork_tree_id_7273528e    INDEX     g   CREATE INDEX projects_typeofwork_tree_id_7273528e ON public.projects_typeofwork USING btree (tree_id);
 8   DROP INDEX public.projects_typeofwork_tree_id_7273528e;
       public         	   mplace_db    false    302            x           1259    18562 #   projects_video_producer_id_1db10036    INDEX     e   CREATE INDEX projects_video_producer_id_1db10036 ON public.projects_video USING btree (producer_id);
 7   DROP INDEX public.projects_video_producer_id_1db10036;
       public         	   mplace_db    false    278                       1259    18233    shops_category_name_d4392244    INDEX     W   CREATE INDEX shops_category_name_d4392244 ON public.shops_category USING btree (name);
 0   DROP INDEX public.shops_category_name_d4392244;
       public         	   mplace_db    false    247                       1259    18234 !   shops_category_name_d4392244_like    INDEX     p   CREATE INDEX shops_category_name_d4392244_like ON public.shops_category USING btree (name varchar_pattern_ops);
 5   DROP INDEX public.shops_category_name_d4392244_like;
       public         	   mplace_db    false    247                       1259    18237 !   shops_category_parent_id_3235f8e1    INDEX     a   CREATE INDEX shops_category_parent_id_3235f8e1 ON public.shops_category USING btree (parent_id);
 5   DROP INDEX public.shops_category_parent_id_3235f8e1;
       public         	   mplace_db    false    247                       1259    18235 !   shops_category_slug_b6f15df6_like    INDEX     p   CREATE INDEX shops_category_slug_b6f15df6_like ON public.shops_category USING btree (slug varchar_pattern_ops);
 5   DROP INDEX public.shops_category_slug_b6f15df6_like;
       public         	   mplace_db    false    247            "           1259    18236    shops_category_tree_id_a08948b0    INDEX     ]   CREATE INDEX shops_category_tree_id_a08948b0 ON public.shops_category USING btree (tree_id);
 3   DROP INDEX public.shops_category_tree_id_a08948b0;
       public         	   mplace_db    false    247            ]           1259    18352    shops_file_product_id_f4a6eaf7    INDEX     [   CREATE INDEX shops_file_product_id_f4a6eaf7 ON public.shops_file USING btree (product_id);
 2   DROP INDEX public.shops_file_product_id_f4a6eaf7;
       public         	   mplace_db    false    266            ^           1259    18353     shops_file_publisher_id_eac878bc    INDEX     _   CREATE INDEX shops_file_publisher_id_eac878bc ON public.shops_file USING btree (publisher_id);
 4   DROP INDEX public.shops_file_publisher_id_eac878bc;
       public         	   mplace_db    false    266            Y           1259    18340    shops_image_product_id_e1919394    INDEX     ]   CREATE INDEX shops_image_product_id_e1919394 ON public.shops_image USING btree (product_id);
 3   DROP INDEX public.shops_image_product_id_e1919394;
       public         	   mplace_db    false    264            Z           1259    18341 !   shops_image_publisher_id_a08377eb    INDEX     a   CREATE INDEX shops_image_publisher_id_a08377eb ON public.shops_image USING btree (publisher_id);
 5   DROP INDEX public.shops_image_publisher_id_a08377eb;
       public         	   mplace_db    false    264            4           1259    18278 "   shops_product_category_id_75a38fc1    INDEX     c   CREATE INDEX shops_product_category_id_75a38fc1 ON public.shops_product USING btree (category_id);
 6   DROP INDEX public.shops_product_category_id_75a38fc1;
       public         	   mplace_db    false    255            5           1259    18280 "   shops_product_id_slug_63bf7e5d_idx    INDEX     `   CREATE INDEX shops_product_id_slug_63bf7e5d_idx ON public.shops_product USING btree (id, slug);
 6   DROP INDEX public.shops_product_id_slug_63bf7e5d_idx;
       public         	   mplace_db    false    255    255            :           1259    18279    shops_product_shop_id_b4feef5b    INDEX     [   CREATE INDEX shops_product_shop_id_b4feef5b ON public.shops_product USING btree (shop_id);
 2   DROP INDEX public.shops_product_shop_id_b4feef5b;
       public         	   mplace_db    false    255            ;           1259    18277     shops_product_slug_5e86361f_like    INDEX     n   CREATE INDEX shops_product_slug_5e86361f_like ON public.shops_product USING btree (slug varchar_pattern_ops);
 4   DROP INDEX public.shops_product_slug_5e86361f_like;
       public         	   mplace_db    false    255            >           1259    18275    shops_product_title_3a724f47    INDEX     W   CREATE INDEX shops_product_title_3a724f47 ON public.shops_product USING btree (title);
 0   DROP INDEX public.shops_product_title_3a724f47;
       public         	   mplace_db    false    255            ?           1259    18276 !   shops_product_title_3a724f47_like    INDEX     p   CREATE INDEX shops_product_title_3a724f47_like ON public.shops_product USING btree (title varchar_pattern_ops);
 5   DROP INDEX public.shops_product_title_3a724f47_like;
       public         	   mplace_db    false    255            _           1259    18364 -   shops_productcontent_content_type_id_b780db43    INDEX     y   CREATE INDEX shops_productcontent_content_type_id_b780db43 ON public.shops_productcontent USING btree (content_type_id);
 A   DROP INDEX public.shops_productcontent_content_type_id_b780db43;
       public         	   mplace_db    false    268            b           1259    18365 (   shops_productcontent_product_id_83143d60    INDEX     o   CREATE INDEX shops_productcontent_product_id_83143d60 ON public.shops_productcontent USING btree (product_id);
 <   DROP INDEX public.shops_productcontent_product_id_83143d60;
       public         	   mplace_db    false    268            P           1259    18317 %   shops_productimage_galary_id_bf8c0dcd    INDEX     i   CREATE INDEX shops_productimage_galary_id_bf8c0dcd ON public.shops_productimage USING btree (galary_id);
 9   DROP INDEX public.shops_productimage_galary_id_bf8c0dcd;
       public         	   mplace_db    false    260            @           1259    18299 "   shops_service_category_id_0e173bbf    INDEX     c   CREATE INDEX shops_service_category_id_0e173bbf ON public.shops_service USING btree (category_id);
 6   DROP INDEX public.shops_service_category_id_0e173bbf;
       public         	   mplace_db    false    257            A           1259    18301 "   shops_service_id_slug_7bb3c993_idx    INDEX     `   CREATE INDEX shops_service_id_slug_7bb3c993_idx ON public.shops_service USING btree (id, slug);
 6   DROP INDEX public.shops_service_id_slug_7bb3c993_idx;
       public         	   mplace_db    false    257    257            F           1259    18300    shops_service_shop_id_b802d72e    INDEX     [   CREATE INDEX shops_service_shop_id_b802d72e ON public.shops_service USING btree (shop_id);
 2   DROP INDEX public.shops_service_shop_id_b802d72e;
       public         	   mplace_db    false    257            G           1259    18298     shops_service_slug_b51d5bbf_like    INDEX     n   CREATE INDEX shops_service_slug_b51d5bbf_like ON public.shops_service USING btree (slug varchar_pattern_ops);
 4   DROP INDEX public.shops_service_slug_b51d5bbf_like;
       public         	   mplace_db    false    257            J           1259    18296    shops_service_title_f0c68cf8    INDEX     W   CREATE INDEX shops_service_title_f0c68cf8 ON public.shops_service USING btree (title);
 0   DROP INDEX public.shops_service_title_f0c68cf8;
       public         	   mplace_db    false    257            K           1259    18297 !   shops_service_title_f0c68cf8_like    INDEX     p   CREATE INDEX shops_service_title_f0c68cf8_like ON public.shops_service USING btree (title varchar_pattern_ops);
 5   DROP INDEX public.shops_service_title_f0c68cf8_like;
       public         	   mplace_db    false    257            .           1259    18258 $   shops_shop_employes_shop_id_30c5d437    INDEX     g   CREATE INDEX shops_shop_employes_shop_id_30c5d437 ON public.shops_shop_employes USING btree (shop_id);
 8   DROP INDEX public.shops_shop_employes_shop_id_30c5d437;
       public         	   mplace_db    false    251            1           1259    18259 $   shops_shop_employes_user_id_10cbf893    INDEX     g   CREATE INDEX shops_shop_employes_user_id_10cbf893 ON public.shops_shop_employes USING btree (user_id);
 8   DROP INDEX public.shops_shop_employes_user_id_10cbf893;
       public         	   mplace_db    false    251            #           1259    18245    shops_shop_owner_id_9a9c8ee7    INDEX     W   CREATE INDEX shops_shop_owner_id_9a9c8ee7 ON public.shops_shop USING btree (owner_id);
 0   DROP INDEX public.shops_shop_owner_id_9a9c8ee7;
       public         	   mplace_db    false    249            &           1259    18243    shops_shop_slug_126a7d68_like    INDEX     h   CREATE INDEX shops_shop_slug_126a7d68_like ON public.shops_shop USING btree (slug varchar_pattern_ops);
 1   DROP INDEX public.shops_shop_slug_126a7d68_like;
       public         	   mplace_db    false    249            )           1259    18244 (   shops_shop_template_prefix_42c67534_like    INDEX     ~   CREATE INDEX shops_shop_template_prefix_42c67534_like ON public.shops_shop USING btree (template_prefix varchar_pattern_ops);
 <   DROP INDEX public.shops_shop_template_prefix_42c67534_like;
       public         	   mplace_db    false    249            U           1259    18328    shops_text_product_id_557719ad    INDEX     [   CREATE INDEX shops_text_product_id_557719ad ON public.shops_text USING btree (product_id);
 2   DROP INDEX public.shops_text_product_id_557719ad;
       public         	   mplace_db    false    262            V           1259    18329     shops_text_publisher_id_df93f6bd    INDEX     _   CREATE INDEX shops_text_publisher_id_df93f6bd ON public.shops_text USING btree (publisher_id);
 4   DROP INDEX public.shops_text_publisher_id_df93f6bd;
       public         	   mplace_db    false    262            i           1259    18384 /   shops_wishlist_products_servicetype_id_2025e62b    INDEX     }   CREATE INDEX shops_wishlist_products_servicetype_id_2025e62b ON public.shops_wishlist_products USING btree (servicetype_id);
 C   DROP INDEX public.shops_wishlist_products_servicetype_id_2025e62b;
       public         	   mplace_db    false    272            j           1259    18383 ,   shops_wishlist_products_wishlist_id_1a35842e    INDEX     w   CREATE INDEX shops_wishlist_products_wishlist_id_1a35842e ON public.shops_wishlist_products USING btree (wishlist_id);
 @   DROP INDEX public.shops_wishlist_products_wishlist_id_1a35842e;
       public         	   mplace_db    false    272            �           1259    18700 #   thumbnail_kvstore_key_3f850178_like    INDEX     t   CREATE INDEX thumbnail_kvstore_key_3f850178_like ON public.thumbnail_kvstore USING btree (key varchar_pattern_ops);
 7   DROP INDEX public.thumbnail_kvstore_key_3f850178_like;
       public         	   mplace_db    false    300            �           2606    17915 E   account_contact account_contact_user_from_id_5ac376e2_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_contact
    ADD CONSTRAINT account_contact_user_from_id_5ac376e2_fk_auth_user_id FOREIGN KEY (user_from_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.account_contact DROP CONSTRAINT account_contact_user_from_id_5ac376e2_fk_auth_user_id;
       public       	   mplace_db    false    3264    211    231            �           2606    17920 C   account_contact account_contact_user_to_id_51f55e86_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_contact
    ADD CONSTRAINT account_contact_user_to_id_51f55e86_fk_auth_user_id FOREIGN KEY (user_to_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 m   ALTER TABLE ONLY public.account_contact DROP CONSTRAINT account_contact_user_to_id_51f55e86_fk_auth_user_id;
       public       	   mplace_db    false    211    231    3264            �           2606    17928 @   account_dialogs account_dialogs_room_id_b972e0b6_fk_chat_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_dialogs
    ADD CONSTRAINT account_dialogs_room_id_b972e0b6_fk_chat_room_id FOREIGN KEY (room_id) REFERENCES public.chat_room(id) DEFERRABLE INITIALLY DEFERRED;
 j   ALTER TABLE ONLY public.account_dialogs DROP CONSTRAINT account_dialogs_room_id_b972e0b6_fk_chat_room_id;
       public       	   mplace_db    false    3281    217    233            �           2606    17933 K   account_dialogs account_dialogs_user_from_id_4ee99014_fk_account_profile_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_dialogs
    ADD CONSTRAINT account_dialogs_user_from_id_4ee99014_fk_account_profile_id FOREIGN KEY (user_from_id) REFERENCES public.account_profile(id) DEFERRABLE INITIALLY DEFERRED;
 u   ALTER TABLE ONLY public.account_dialogs DROP CONSTRAINT account_dialogs_user_from_id_4ee99014_fk_account_profile_id;
       public       	   mplace_db    false    3298    233    225            �           2606    17938 I   account_dialogs account_dialogs_user_to_id_50c7c3f0_fk_account_profile_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_dialogs
    ADD CONSTRAINT account_dialogs_user_to_id_50c7c3f0_fk_account_profile_id FOREIGN KEY (user_to_id) REFERENCES public.account_profile(id) DEFERRABLE INITIALLY DEFERRED;
 s   ALTER TABLE ONLY public.account_dialogs DROP CONSTRAINT account_dialogs_user_to_id_50c7c3f0_fk_account_profile_id;
       public       	   mplace_db    false    233    3298    225            �           2606    17895 @   account_profile account_profile_user_id_bdd52018_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_profile
    ADD CONSTRAINT account_profile_user_id_bdd52018_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 j   ALTER TABLE ONLY public.account_profile DROP CONSTRAINT account_profile_user_id_bdd52018_fk_auth_user_id;
       public       	   mplace_db    false    225    3264    211            �           2606    17902 T   account_profiletoprofession account_profiletopro_profession_id_1e3b7c90_fk_account_p    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_profiletoprofession
    ADD CONSTRAINT account_profiletopro_profession_id_1e3b7c90_fk_account_p FOREIGN KEY (profession_id) REFERENCES public.account_profession(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.account_profiletoprofession DROP CONSTRAINT account_profiletopro_profession_id_1e3b7c90_fk_account_p;
       public       	   mplace_db    false    3302    227    229            �           2606    17907 P   account_profiletoprofession account_profiletopro_worker_id_0b2eb064_fk_account_p    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_profiletoprofession
    ADD CONSTRAINT account_profiletopro_worker_id_0b2eb064_fk_account_p FOREIGN KEY (worker_id) REFERENCES public.account_profile(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.account_profiletoprofession DROP CONSTRAINT account_profiletopro_worker_id_0b2eb064_fk_account_p;
       public       	   mplace_db    false    3298    229    225            �           2606    17955 M   actions_action actions_action_target_ct_id_63e2300e_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.actions_action
    ADD CONSTRAINT actions_action_target_ct_id_63e2300e_fk_django_content_type_id FOREIGN KEY (target_ct_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 w   ALTER TABLE ONLY public.actions_action DROP CONSTRAINT actions_action_target_ct_id_63e2300e_fk_django_content_type_id;
       public       	   mplace_db    false    3246    203    235            �           2606    17960 >   actions_action actions_action_user_id_f34f0949_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.actions_action
    ADD CONSTRAINT actions_action_user_id_f34f0949_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 h   ALTER TABLE ONLY public.actions_action DROP CONSTRAINT actions_action_user_id_f34f0949_fk_auth_user_id;
       public       	   mplace_db    false    235    211    3264            �           2606    17735 O   auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
       public       	   mplace_db    false    205    209    3251            �           2606    17730 P   auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public       	   mplace_db    false    209    3256    207            �           2606    17721 E   auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
       public       	   mplace_db    false    205    203    3246            �           2606    17750 D   auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id;
       public       	   mplace_db    false    3256    213    207            �           2606    17745 B   auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
       public       	   mplace_db    false    3264    213    211            �           2606    17764 S   auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
       public       	   mplace_db    false    205    3251    215            �           2606    17759 V   auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
       public       	   mplace_db    false    211    215    3264            �           2606    17827 B   chat_chatmessage chat_chatmessage_chat_id_356f3993_fk_chat_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat_chatmessage
    ADD CONSTRAINT chat_chatmessage_chat_id_356f3993_fk_chat_room_id FOREIGN KEY (chat_id) REFERENCES public.chat_room(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.chat_chatmessage DROP CONSTRAINT chat_chatmessage_chat_id_356f3993_fk_chat_room_id;
       public       	   mplace_db    false    217    3281    221            �           2606    17832 B   chat_chatmessage chat_chatmessage_user_id_fa615e65_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat_chatmessage
    ADD CONSTRAINT chat_chatmessage_user_id_fa615e65_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.chat_chatmessage DROP CONSTRAINT chat_chatmessage_user_id_fa615e65_fk_auth_user_id;
       public       	   mplace_db    false    221    3264    211            �           2606    17839 J   chat_chatmessagepack chat_chatmessagepack_chat_id_bac9aefa_fk_chat_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat_chatmessagepack
    ADD CONSTRAINT chat_chatmessagepack_chat_id_bac9aefa_fk_chat_room_id FOREIGN KEY (chat_id) REFERENCES public.chat_room(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.chat_chatmessagepack DROP CONSTRAINT chat_chatmessagepack_chat_id_bac9aefa_fk_chat_room_id;
       public       	   mplace_db    false    223    3281    217            �           2606    17844 K   chat_chatmessagepack chat_chatmessagepack_previous_id_ced021b4_fk_chat_chat    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat_chatmessagepack
    ADD CONSTRAINT chat_chatmessagepack_previous_id_ced021b4_fk_chat_chat FOREIGN KEY (previous_id) REFERENCES public.chat_chatmessagepack(id) DEFERRABLE INITIALLY DEFERRED;
 u   ALTER TABLE ONLY public.chat_chatmessagepack DROP CONSTRAINT chat_chatmessagepack_previous_id_ced021b4_fk_chat_chat;
       public       	   mplace_db    false    223    3294    223            �           2606    17813 D   chat_room_members chat_room_members_room_id_45721890_fk_chat_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat_room_members
    ADD CONSTRAINT chat_room_members_room_id_45721890_fk_chat_room_id FOREIGN KEY (room_id) REFERENCES public.chat_room(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.chat_room_members DROP CONSTRAINT chat_room_members_room_id_45721890_fk_chat_room_id;
       public       	   mplace_db    false    3281    217    219            �           2606    17818 D   chat_room_members chat_room_members_user_id_78b43a81_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat_room_members
    ADD CONSTRAINT chat_room_members_user_id_78b43a81_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.chat_room_members DROP CONSTRAINT chat_room_members_user_id_78b43a81_fk_auth_user_id;
       public       	   mplace_db    false    219    3264    211            �           2606    17982 G   django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
       public       	   mplace_db    false    3246    237    203            �           2606    17987 B   django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id;
       public       	   mplace_db    false    3264    211    237            �           2606    18070 <   images_galary images_galary_user_id_b23face0_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.images_galary
    ADD CONSTRAINT images_galary_user_id_b23face0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 f   ALTER TABLE ONLY public.images_galary DROP CONSTRAINT images_galary_user_id_b23face0_fk_auth_user_id;
       public       	   mplace_db    false    211    3264    245            �           2606    18033 :   images_image images_image_user_id_55499d60_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.images_image
    ADD CONSTRAINT images_image_user_id_55499d60_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 d   ALTER TABLE ONLY public.images_image DROP CONSTRAINT images_image_user_id_55499d60_fk_auth_user_id;
       public       	   mplace_db    false    241    3264    211            �           2606    18042 T   images_image_users_like images_image_users_like_image_id_8b6abde8_fk_images_image_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.images_image_users_like
    ADD CONSTRAINT images_image_users_like_image_id_8b6abde8_fk_images_image_id FOREIGN KEY (image_id) REFERENCES public.images_image(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.images_image_users_like DROP CONSTRAINT images_image_users_like_image_id_8b6abde8_fk_images_image_id;
       public       	   mplace_db    false    241    3337    243            �           2606    18047 P   images_image_users_like images_image_users_like_user_id_72060bdd_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.images_image_users_like
    ADD CONSTRAINT images_image_users_like_user_id_72060bdd_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.images_image_users_like DROP CONSTRAINT images_image_users_like_user_id_72060bdd_fk_auth_user_id;
       public       	   mplace_db    false    211    3264    243            �           2606    18410 A   orders_order orders_order_coupon_id_5bddb887_fk_coupons_coupon_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_coupon_id_5bddb887_fk_coupons_coupon_id FOREIGN KEY (coupon_id) REFERENCES public.coupons_coupon(id) DEFERRABLE INITIALLY DEFERRED;
 k   ALTER TABLE ONLY public.orders_order DROP CONSTRAINT orders_order_coupon_id_5bddb887_fk_coupons_coupon_id;
       public       	   mplace_db    false    3334    239    274            �           2606    18405 :   orders_order orders_order_user_id_e9b59eb1_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_user_id_e9b59eb1_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 d   ALTER TABLE ONLY public.orders_order DROP CONSTRAINT orders_order_user_id_e9b59eb1_fk_auth_user_id;
       public       	   mplace_db    false    3264    274    211            �           2606    18417 F   orders_orderitem orders_orderitem_order_id_fe61a34d_fk_orders_order_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_order_id_fe61a34d_fk_orders_order_id FOREIGN KEY (order_id) REFERENCES public.orders_order(id) DEFERRABLE INITIALLY DEFERRED;
 p   ALTER TABLE ONLY public.orders_orderitem DROP CONSTRAINT orders_orderitem_order_id_fe61a34d_fk_orders_order_id;
       public       	   mplace_db    false    274    276    3439            �           2606    18422 M   orders_orderitem orders_orderitem_product_id_afe4254a_fk_shops_servicetype_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_product_id_afe4254a_fk_shops_servicetype_id FOREIGN KEY (product_id) REFERENCES public.shops_servicetype(id) DEFERRABLE INITIALLY DEFERRED;
 w   ALTER TABLE ONLY public.orders_orderitem DROP CONSTRAINT orders_orderitem_product_id_afe4254a_fk_shops_servicetype_id;
       public       	   mplace_db    false    3379    276    253            �           2606    18427 C   orders_orderitem orders_orderitem_shop_id_268d2151_fk_shops_shop_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_shop_id_268d2151_fk_shops_shop_id FOREIGN KEY (shop_id) REFERENCES public.shops_shop(id) DEFERRABLE INITIALLY DEFERRED;
 m   ALTER TABLE ONLY public.orders_orderitem DROP CONSTRAINT orders_orderitem_shop_id_268d2151_fk_shops_shop_id;
       public       	   mplace_db    false    249    276    3365            �           2606    18620 N   projects_benchmark projects_benchmark_module_id_8db2df7b_fk_projects_module_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_benchmark
    ADD CONSTRAINT projects_benchmark_module_id_8db2df7b_fk_projects_module_id FOREIGN KEY (module_id) REFERENCES public.projects_module(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.projects_benchmark DROP CONSTRAINT projects_benchmark_module_id_8db2df7b_fk_projects_module_id;
       public       	   mplace_db    false    292    3460    284            �           2606    18608 G   projects_content projects_content_content_type_id_eb5c5510_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_content
    ADD CONSTRAINT projects_content_content_type_id_eb5c5510_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.projects_content DROP CONSTRAINT projects_content_content_type_id_eb5c5510_fk_django_co;
       public       	   mplace_db    false    3246    203    290            �           2606    18613 J   projects_content projects_content_module_id_29d1cb12_fk_projects_module_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_content
    ADD CONSTRAINT projects_content_module_id_29d1cb12_fk_projects_module_id FOREIGN KEY (module_id) REFERENCES public.projects_module(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.projects_content DROP CONSTRAINT projects_content_module_id_29d1cb12_fk_projects_module_id;
       public       	   mplace_db    false    284    290    3460            �           2606    18637 K   projects_family projects_family_childrens_id_2f260865_fk_projects_module_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_family
    ADD CONSTRAINT projects_family_childrens_id_2f260865_fk_projects_module_id FOREIGN KEY (childrens_id) REFERENCES public.projects_module(id) DEFERRABLE INITIALLY DEFERRED;
 u   ALTER TABLE ONLY public.projects_family DROP CONSTRAINT projects_family_childrens_id_2f260865_fk_projects_module_id;
       public       	   mplace_db    false    3460    284    296            �           2606    18642 I   projects_family projects_family_parents_id_ee858db2_fk_projects_module_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_family
    ADD CONSTRAINT projects_family_parents_id_ee858db2_fk_projects_module_id FOREIGN KEY (parents_id) REFERENCES public.projects_module(id) DEFERRABLE INITIALLY DEFERRED;
 s   ALTER TABLE ONLY public.projects_family DROP CONSTRAINT projects_family_parents_id_ee858db2_fk_projects_module_id;
       public       	   mplace_db    false    3460    284    296            �           2606    18602 A   projects_file projects_file_producer_id_82c18b0c_fk_shops_shop_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_file
    ADD CONSTRAINT projects_file_producer_id_82c18b0c_fk_shops_shop_id FOREIGN KEY (producer_id) REFERENCES public.shops_shop(id) DEFERRABLE INITIALLY DEFERRED;
 k   ALTER TABLE ONLY public.projects_file DROP CONSTRAINT projects_file_producer_id_82c18b0c_fk_shops_shop_id;
       public       	   mplace_db    false    288    249    3365            �           2606    18596 C   projects_image projects_image_producer_id_7c57c72e_fk_shops_shop_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_image
    ADD CONSTRAINT projects_image_producer_id_7c57c72e_fk_shops_shop_id FOREIGN KEY (producer_id) REFERENCES public.shops_shop(id) DEFERRABLE INITIALLY DEFERRED;
 m   ALTER TABLE ONLY public.projects_image DROP CONSTRAINT projects_image_producer_id_7c57c72e_fk_shops_shop_id;
       public       	   mplace_db    false    3365    249    286            �           2606    18632 L   projects_module projects_module_producer_id_1f0de955_fk_projects_producer_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_module
    ADD CONSTRAINT projects_module_producer_id_1f0de955_fk_projects_producer_id FOREIGN KEY (producer_id) REFERENCES public.projects_producer(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.projects_module DROP CONSTRAINT projects_module_producer_id_1f0de955_fk_projects_producer_id;
       public       	   mplace_db    false    284    3479    294            �           2606    18650 O   projects_module projects_module_profession_id_8d10259c_fk_account_profession_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_module
    ADD CONSTRAINT projects_module_profession_id_8d10259c_fk_account_profession_id FOREIGN KEY (profession_id) REFERENCES public.account_profession(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.projects_module DROP CONSTRAINT projects_module_profession_id_8d10259c_fk_account_profession_id;
       public       	   mplace_db    false    284    3302    227            �           2606    18590 J   projects_module projects_module_project_id_5ce2732a_fk_projects_project_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_module
    ADD CONSTRAINT projects_module_project_id_5ce2732a_fk_projects_project_id FOREIGN KEY (project_id) REFERENCES public.projects_project(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.projects_module DROP CONSTRAINT projects_module_project_id_5ce2732a_fk_projects_project_id;
       public       	   mplace_db    false    282    284    3454            �           2606    18626 I   projects_producer projects_producer_producer_id_1e753690_fk_shops_shop_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_producer
    ADD CONSTRAINT projects_producer_producer_id_1e753690_fk_shops_shop_id FOREIGN KEY (producer_id) REFERENCES public.shops_shop(id) DEFERRABLE INITIALLY DEFERRED;
 s   ALTER TABLE ONLY public.projects_producer DROP CONSTRAINT projects_producer_producer_id_1e753690_fk_shops_shop_id;
       public       	   mplace_db    false    249    294    3365            �           2606    18577 F   projects_project projects_project_customer_id_731c79d1_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_project
    ADD CONSTRAINT projects_project_customer_id_731c79d1_fk_auth_user_id FOREIGN KEY (customer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 p   ALTER TABLE ONLY public.projects_project DROP CONSTRAINT projects_project_customer_id_731c79d1_fk_auth_user_id;
       public       	   mplace_db    false    3264    282    211            �           2606    18725 L   projects_project projects_project_type_id_6a1aa51a_fk_projects_typeofwork_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_project
    ADD CONSTRAINT projects_project_type_id_6a1aa51a_fk_projects_typeofwork_id FOREIGN KEY (type_id) REFERENCES public.projects_typeofwork(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.projects_project DROP CONSTRAINT projects_project_type_id_6a1aa51a_fk_projects_typeofwork_id;
       public       	   mplace_db    false    282    302    3498            �           2606    18655 L   projects_projectrespond projects_projectresp_module_id_0edd22d0_fk_projects_    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_projectrespond
    ADD CONSTRAINT projects_projectresp_module_id_0edd22d0_fk_projects_ FOREIGN KEY (module_id) REFERENCES public.projects_module(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.projects_projectrespond DROP CONSTRAINT projects_projectresp_module_id_0edd22d0_fk_projects_;
       public       	   mplace_db    false    298    3460    284            �           2606    18660 U   projects_projectrespond projects_projectrespond_responded_id_ae590a31_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_projectrespond
    ADD CONSTRAINT projects_projectrespond_responded_id_ae590a31_fk_auth_user_id FOREIGN KEY (responded_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
    ALTER TABLE ONLY public.projects_projectrespond DROP CONSTRAINT projects_projectrespond_responded_id_ae590a31_fk_auth_user_id;
       public       	   mplace_db    false    3264    211    298            �           2606    18571 A   projects_text projects_text_producer_id_e23c81ca_fk_shops_shop_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_text
    ADD CONSTRAINT projects_text_producer_id_e23c81ca_fk_shops_shop_id FOREIGN KEY (producer_id) REFERENCES public.shops_shop(id) DEFERRABLE INITIALLY DEFERRED;
 k   ALTER TABLE ONLY public.projects_text DROP CONSTRAINT projects_text_producer_id_e23c81ca_fk_shops_shop_id;
       public       	   mplace_db    false    249    3365    280            �           2606    18716 G   projects_typeofwork projects_typeofwork_parent_id_5627f020_fk_projects_    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_typeofwork
    ADD CONSTRAINT projects_typeofwork_parent_id_5627f020_fk_projects_ FOREIGN KEY (parent_id) REFERENCES public.projects_typeofwork(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.projects_typeofwork DROP CONSTRAINT projects_typeofwork_parent_id_5627f020_fk_projects_;
       public       	   mplace_db    false    3498    302    302            �           2606    18557 C   projects_video projects_video_producer_id_1db10036_fk_shops_shop_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects_video
    ADD CONSTRAINT projects_video_producer_id_1db10036_fk_shops_shop_id FOREIGN KEY (producer_id) REFERENCES public.shops_shop(id) DEFERRABLE INITIALLY DEFERRED;
 m   ALTER TABLE ONLY public.projects_video DROP CONSTRAINT projects_video_producer_id_1db10036_fk_shops_shop_id;
       public       	   mplace_db    false    3365    278    249            �           2606    18228 E   shops_category shops_category_parent_id_3235f8e1_fk_shops_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_category
    ADD CONSTRAINT shops_category_parent_id_3235f8e1_fk_shops_category_id FOREIGN KEY (parent_id) REFERENCES public.shops_category(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.shops_category DROP CONSTRAINT shops_category_parent_id_3235f8e1_fk_shops_category_id;
       public       	   mplace_db    false    3358    247    247            �           2606    18342 A   shops_file shops_file_product_id_f4a6eaf7_fk_shops_servicetype_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_file
    ADD CONSTRAINT shops_file_product_id_f4a6eaf7_fk_shops_servicetype_id FOREIGN KEY (product_id) REFERENCES public.shops_servicetype(id) DEFERRABLE INITIALLY DEFERRED;
 k   ALTER TABLE ONLY public.shops_file DROP CONSTRAINT shops_file_product_id_f4a6eaf7_fk_shops_servicetype_id;
       public       	   mplace_db    false    3379    253    266            �           2606    18347 ;   shops_file shops_file_publisher_id_eac878bc_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_file
    ADD CONSTRAINT shops_file_publisher_id_eac878bc_fk_auth_user_id FOREIGN KEY (publisher_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 e   ALTER TABLE ONLY public.shops_file DROP CONSTRAINT shops_file_publisher_id_eac878bc_fk_auth_user_id;
       public       	   mplace_db    false    266    211    3264            �           2606    18330 C   shops_image shops_image_product_id_e1919394_fk_shops_servicetype_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_image
    ADD CONSTRAINT shops_image_product_id_e1919394_fk_shops_servicetype_id FOREIGN KEY (product_id) REFERENCES public.shops_servicetype(id) DEFERRABLE INITIALLY DEFERRED;
 m   ALTER TABLE ONLY public.shops_image DROP CONSTRAINT shops_image_product_id_e1919394_fk_shops_servicetype_id;
       public       	   mplace_db    false    264    253    3379            �           2606    18335 =   shops_image shops_image_publisher_id_a08377eb_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_image
    ADD CONSTRAINT shops_image_publisher_id_a08377eb_fk_auth_user_id FOREIGN KEY (publisher_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 g   ALTER TABLE ONLY public.shops_image DROP CONSTRAINT shops_image_publisher_id_a08377eb_fk_auth_user_id;
       public       	   mplace_db    false    3264    211    264            �           2606    18260 E   shops_product shops_product_category_id_75a38fc1_fk_shops_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_product
    ADD CONSTRAINT shops_product_category_id_75a38fc1_fk_shops_category_id FOREIGN KEY (category_id) REFERENCES public.shops_category(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.shops_product DROP CONSTRAINT shops_product_category_id_75a38fc1_fk_shops_category_id;
       public       	   mplace_db    false    255    3358    247            �           2606    18677 L   shops_product shops_product_service_type_id_174acceb_fk_shops_servicetype_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_product
    ADD CONSTRAINT shops_product_service_type_id_174acceb_fk_shops_servicetype_id FOREIGN KEY (service_type_id) REFERENCES public.shops_servicetype(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.shops_product DROP CONSTRAINT shops_product_service_type_id_174acceb_fk_shops_servicetype_id;
       public       	   mplace_db    false    3379    253    255            �           2606    18265 =   shops_product shops_product_shop_id_b4feef5b_fk_shops_shop_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_product
    ADD CONSTRAINT shops_product_shop_id_b4feef5b_fk_shops_shop_id FOREIGN KEY (shop_id) REFERENCES public.shops_shop(id) DEFERRABLE INITIALLY DEFERRED;
 g   ALTER TABLE ONLY public.shops_product DROP CONSTRAINT shops_product_shop_id_b4feef5b_fk_shops_shop_id;
       public       	   mplace_db    false    249    255    3365            �           2606    18354 O   shops_productcontent shops_productcontent_content_type_id_b780db43_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_productcontent
    ADD CONSTRAINT shops_productcontent_content_type_id_b780db43_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.shops_productcontent DROP CONSTRAINT shops_productcontent_content_type_id_b780db43_fk_django_co;
       public       	   mplace_db    false    3246    203    268            �           2606    18359 J   shops_productcontent shops_productcontent_product_id_83143d60_fk_shops_ser    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_productcontent
    ADD CONSTRAINT shops_productcontent_product_id_83143d60_fk_shops_ser FOREIGN KEY (product_id) REFERENCES public.shops_servicetype(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.shops_productcontent DROP CONSTRAINT shops_productcontent_product_id_83143d60_fk_shops_ser;
       public       	   mplace_db    false    3379    253    268            �           2606    18682 S   shops_productgalary shops_productgalary_service_id_c9d70ecb_fk_shops_servicetype_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_productgalary
    ADD CONSTRAINT shops_productgalary_service_id_c9d70ecb_fk_shops_servicetype_id FOREIGN KEY (service_id) REFERENCES public.shops_servicetype(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.shops_productgalary DROP CONSTRAINT shops_productgalary_service_id_c9d70ecb_fk_shops_servicetype_id;
       public       	   mplace_db    false    3379    259    253            �           2606    18312 R   shops_productimage shops_productimage_galary_id_bf8c0dcd_fk_shops_productgalary_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_productimage
    ADD CONSTRAINT shops_productimage_galary_id_bf8c0dcd_fk_shops_productgalary_id FOREIGN KEY (galary_id) REFERENCES public.shops_productgalary(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.shops_productimage DROP CONSTRAINT shops_productimage_galary_id_bf8c0dcd_fk_shops_productgalary_id;
       public       	   mplace_db    false    259    260    3405            �           2606    18307 N   shops_productimage shops_productimage_image_ptr_id_85b4c685_fk_images_image_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_productimage
    ADD CONSTRAINT shops_productimage_image_ptr_id_85b4c685_fk_images_image_id FOREIGN KEY (image_ptr_id) REFERENCES public.images_image(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.shops_productimage DROP CONSTRAINT shops_productimage_image_ptr_id_85b4c685_fk_images_image_id;
       public       	   mplace_db    false    260    3337    241            �           2606    18281 E   shops_service shops_service_category_id_0e173bbf_fk_shops_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_service
    ADD CONSTRAINT shops_service_category_id_0e173bbf_fk_shops_category_id FOREIGN KEY (category_id) REFERENCES public.shops_category(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.shops_service DROP CONSTRAINT shops_service_category_id_0e173bbf_fk_shops_category_id;
       public       	   mplace_db    false    3358    257    247            �           2606    18687 L   shops_service shops_service_service_type_id_42ff54fc_fk_shops_servicetype_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_service
    ADD CONSTRAINT shops_service_service_type_id_42ff54fc_fk_shops_servicetype_id FOREIGN KEY (service_type_id) REFERENCES public.shops_servicetype(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.shops_service DROP CONSTRAINT shops_service_service_type_id_42ff54fc_fk_shops_servicetype_id;
       public       	   mplace_db    false    3379    257    253            �           2606    18286 =   shops_service shops_service_shop_id_b802d72e_fk_shops_shop_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_service
    ADD CONSTRAINT shops_service_shop_id_b802d72e_fk_shops_shop_id FOREIGN KEY (shop_id) REFERENCES public.shops_shop(id) DEFERRABLE INITIALLY DEFERRED;
 g   ALTER TABLE ONLY public.shops_service DROP CONSTRAINT shops_service_shop_id_b802d72e_fk_shops_shop_id;
       public       	   mplace_db    false    257    3365    249            �           2606    18246 I   shops_shop_employes shops_shop_employes_shop_id_30c5d437_fk_shops_shop_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_shop_employes
    ADD CONSTRAINT shops_shop_employes_shop_id_30c5d437_fk_shops_shop_id FOREIGN KEY (shop_id) REFERENCES public.shops_shop(id) DEFERRABLE INITIALLY DEFERRED;
 s   ALTER TABLE ONLY public.shops_shop_employes DROP CONSTRAINT shops_shop_employes_shop_id_30c5d437_fk_shops_shop_id;
       public       	   mplace_db    false    249    251    3365            �           2606    18251 H   shops_shop_employes shops_shop_employes_user_id_10cbf893_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_shop_employes
    ADD CONSTRAINT shops_shop_employes_user_id_10cbf893_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 r   ALTER TABLE ONLY public.shops_shop_employes DROP CONSTRAINT shops_shop_employes_user_id_10cbf893_fk_auth_user_id;
       public       	   mplace_db    false    3264    251    211            �           2606    18238 7   shops_shop shops_shop_owner_id_9a9c8ee7_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_shop
    ADD CONSTRAINT shops_shop_owner_id_9a9c8ee7_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 a   ALTER TABLE ONLY public.shops_shop DROP CONSTRAINT shops_shop_owner_id_9a9c8ee7_fk_auth_user_id;
       public       	   mplace_db    false    211    249    3264            �           2606    18318 A   shops_text shops_text_product_id_557719ad_fk_shops_servicetype_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_text
    ADD CONSTRAINT shops_text_product_id_557719ad_fk_shops_servicetype_id FOREIGN KEY (product_id) REFERENCES public.shops_servicetype(id) DEFERRABLE INITIALLY DEFERRED;
 k   ALTER TABLE ONLY public.shops_text DROP CONSTRAINT shops_text_product_id_557719ad_fk_shops_servicetype_id;
       public       	   mplace_db    false    253    3379    262            �           2606    18323 ;   shops_text shops_text_publisher_id_df93f6bd_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_text
    ADD CONSTRAINT shops_text_publisher_id_df93f6bd_fk_auth_user_id FOREIGN KEY (publisher_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 e   ALTER TABLE ONLY public.shops_text DROP CONSTRAINT shops_text_publisher_id_df93f6bd_fk_auth_user_id;
       public       	   mplace_db    false    211    262    3264            �           2606    18366 ?   shops_wishlist shops_wishlist_owner_id_cd59fd3c_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_wishlist
    ADD CONSTRAINT shops_wishlist_owner_id_cd59fd3c_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 i   ALTER TABLE ONLY public.shops_wishlist DROP CONSTRAINT shops_wishlist_owner_id_cd59fd3c_fk_auth_user_id;
       public       	   mplace_db    false    3264    270    211            �           2606    18376 Q   shops_wishlist_products shops_wishlist_produ_servicetype_id_2025e62b_fk_shops_ser    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_wishlist_products
    ADD CONSTRAINT shops_wishlist_produ_servicetype_id_2025e62b_fk_shops_ser FOREIGN KEY (servicetype_id) REFERENCES public.shops_servicetype(id) DEFERRABLE INITIALLY DEFERRED;
 {   ALTER TABLE ONLY public.shops_wishlist_products DROP CONSTRAINT shops_wishlist_produ_servicetype_id_2025e62b_fk_shops_ser;
       public       	   mplace_db    false    253    272    3379            �           2606    18371 N   shops_wishlist_products shops_wishlist_produ_wishlist_id_1a35842e_fk_shops_wis    FK CONSTRAINT     �   ALTER TABLE ONLY public.shops_wishlist_products
    ADD CONSTRAINT shops_wishlist_produ_wishlist_id_1a35842e_fk_shops_wis FOREIGN KEY (wishlist_id) REFERENCES public.shops_wishlist(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.shops_wishlist_products DROP CONSTRAINT shops_wishlist_produ_wishlist_id_1a35842e_fk_shops_wis;
       public       	   mplace_db    false    270    272    3430            �      x������ � �      �      x������ � �      �      x������ � �      �   3   x�3���,-N-*�7202�7��7���/-�O�/�/�+�K�4����� ��      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�]�M�0��������u��RA�R��6k�(�T?��\~�e-+���(3	�Kf�wY��E24��-ݻ�fU���ݣ��Z��).��cꎟ9�:�`�66���� �C��}fa�&tв��PS��қ�Ѝ3�˙�-\�x���g��c��q-�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   ]   x�3�4202�5��5�T04�2��26�316624�60�4�(�O��IUH�/R(-N-R��L��/�DW+%����(Y)T���r��qr��qqq ��      �       x�31�LLN�/�+�,(�O��I����� _�      ~   �  x����r�6����}',��g���h�%*��o� X	4�fz�Hc���`wA�f7��8M���a�����5��3ξ0���? �
�U�V)�����'�i.�뚂o�`���k3�)��-����{�q���3ͬ�S���O��|n^�O5z�H?���-�����������Q�9xpB*��T�c�����΁�1�n��v��^��0�X�*�,A{�­�� �ܮx	��4�]�NC���ߍm3��5�(I��q���yM%K�.����� Jqj)���>Ux������~�>���CͿ�B�	�2a�Vϱ�j�K+��
W��1�Jg�2"*�t�Cw\MoN���r�5���������5��^�-�B���!(���s߼�	�][� ��<'2\|?��?��K�Q���������2L�.f���.g��=4]���d
��1�Ą℆�T_��J�Y�U2��<��u��K_�.!�i=S4nҏK7ζ�~�!lk3C�u*oM��i�q��qƏ��2-y���i���0Kŭ�ٖ����B�J[���`(`W��8\N�a�3��
�1�/'�PR����(�%"f;O�y�~��_�B-R4�g���Cc��Ľ�T��O�7<�us�bӒզ;�]_�1�\��.D�nY��t�V;��e
=)[�y\]o4�ڤ��^}X��f��XX�^��e�K�[X�^�B���J��8�?	���pZ��d[��DcI�5$�\b���JO�"�ŭ\��"*�Yۄ�e7�4}�y����x�S���8��hX�2H}ԝ�������֜����뷈\Ù�3�i�Xec��f�%r���_R��rG�:��V����\��E���Fyv%���^wajMk��N�{�#�S?���	Ufc� ��{��ڵ"��y#�B,D<˳A�k�ZrnC� %~���n"j����;0�7�lA�t!5/�sVg��S�ʅ�T�l@�nՂ�u�^�hN�~��ϔ�D���P��A�u�uv#��8����S˅����E�߼8��9�b(O������?��kߝ�F̮���k\P[.e����0��q�"r��/O��
-�*Դ�Y�
���?5�!��\���jڃ�HԲ-ыB��7Y���B��&�OO��ڠ��nw�j���m��I����K���s+�J(�9eX�8T�B�� ����{=4��y6<1}<9�g�br����丬%��`!�R�<8k SY^�nW�ɡX����P�aO����iՀ�#53� ��OY��n7&�Z�#�\fI��hUKׄ@�̏���0k���l��3�&99�
��n��@,��kv?�<�~"A֒!˃�'�sBA ��O",�{3�%���'T-%1%��V�����-�Vo �@LI;�H��bB ��]P",�E&O�N(��/؎x�SOBxD�0�� ����Axc�ͨއ(��{�뷱=��c�A�rbI�
�|������;��py_HT%��`����>�%��R�9�[�m�p�%�jw���J��v���)�JϢ�R{}I�l��ɧ�Z06ݫ����z9|;6]�6���ʴf����ǥ9��{��ێ�-_z� ��QA{��F����� 8麗&�IC�8��	'n:���[(Lo+��V��ݐ�b������H���[y}E������b���      �   v  x�U��n�0F��ݏ�N1R-�4�v8�f�8�c�����6�*�+�ő���\�J��������K�n��5�L+'�`a�I]T,d�:�S�4ɺ��L�~���2$C'�IdY��U7W�[=?@�/��{�p�SHF0��0�5ʊ�yg鱗��`�<�]���d �@2��>���Q�Zj�"�Ґ��������e�V��s$����N�[�-Thۥ�ԑ>T�3�D��E�>���ɴ��Bgh{��h��Ip���9�@YS}�,���{����Z��Lpv��Q�V)zp�H�Q�D��L�l0���Vܩ^��p�Z�W�;t2�Zp��ɫ��0g��\�_�S�������h8~o��:      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x����N�0Ek���ůď�h)�\��+٠$FvR ��q��X	
�����=�c��:�����öס���(�I��	�`R��*8��f3�P�5��	��
�yZS�1Ō_�j�����}ٿ�����p7�!��?�����0��sx�m'N)=Ի�?�|;2�P"3�B�3�:�,?";�.�4-_<����,P%h#U���A0]��@�.�^B���s�����]�*     
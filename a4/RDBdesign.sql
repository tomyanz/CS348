connect to cs348

create table PRODUCT ( \
  price           float not null, \
  manufacturer    varchar (20) not null, \
  model_number    varchar (10) not null, \
  number_in_stock integer not null, \
  primary key     (model_number) )

create table CAMERA ( \
  sensor_size               integer not null, \
  date_of_release           date not null, \
  pixel_number              integer not null, \
  electronic_viewfinder     boolean not null, \
  other_viewfinder_type     varchar (20) not null, \
  replaceable_lens          boolean not null, \
  lenses                    integer (100) not null, \
  model_number              varchar (10) not null, \
  primary key               (model_number), \
  foreign key               (model_number) references PRODUCT )

create table LENS ( \
  focal_start             integer not null, \
  focal_end               integer not null, \
  aperture_start          integer not null, \
  aperture_end            integer not null, \
  prime                   boolean not null, \
  model_number            varchar (10) not null, \
  primary key             (model_number), \ 
  foreign key             (model_number) references PRODUCT )

create table ORDERS ( \
  model_number        varchar (10) not null, \
  customer_number     integer not null, \
  primary key         (model_number, customer_number), \
  foreign key         (model_number) references PRODUCT, \
  foreign key         (customer_number) references CUSTOMER )

create table CUSTOMER ( \
  customer_number             integer not null, \
  name                        varchar (25) not null, \
  shipping_address            varchar (100) not null, \
  email                       varchar (50) not null, \
  domestic                    boolean not null, \
  primary key                 (customer_number) )

create table EVALUATION ( \
  score               integer not null, \
  comment             varchar (140) not null, \
  model_number        varchar (100) not null, \
  customer_number     varchar (50) not null, \
  domestic            boolean not null, \
  primary key         (model_number, customer_number), \
  foreign key         (model_number) references PRODUCT, \
  foreign key         (customer_number) references CUSTOMER )

create assertion a1
check (LENS.prime == true and (LENS.focal_start == LENS.focal_end)) or
  (LENS.prime == false)

create assertion a2
check (CAMERA.replacable_lens == true and CAMERA.lenses.size >= 2) or
  (CAMERA.replacable_lens == false and CAMERA.lenses.size == 1)

create assertion a3
check (PRODUCT.model_number, exists EVALUATION.model_number)

create assertion a4
check (EVALUATION.score >= 1 and EVALUATION.score <= 5)

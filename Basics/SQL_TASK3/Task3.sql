create database MMORPG;
use MMORPG;

create table accounts(id int not null primary key, username varchar(255));

create table items(
  id int not null primary key
  , type enum('sword', 'shield', 'armour')
  , name varchar(255)
);

create table accounts_items(
  account_id int
  , item_id int
  , quality enum('common', 'rare', 'epic')
  , foreign key(account_id) references accounts(id)
  , foreign key(item_id) references items(id)
);

insert into
  accounts(id, username)
values
  (1, 'cmunns')
  , (2, 'yworcsO');

insert into
  items(id, type, name)
values
  (1, 'sword', 'Sword of Solanaceae')
  , (2, 'shield', 'Shield of Rosaceae')
  , (3, 'shield', 'Shield of Fagaceae')
  , (5, 'shield', 'Shield of Lauraceae')
  , (6, 'sword', 'Sword of Loasaceae')
  , (7, 'armour', 'Armour of Myrateceae')
  , (8, 'shield', 'Shield of Rosaceae')
  , (10, 'shield', 'Shield of Rosaceae');


insert into
  accounts_items(account_id, item_id, quality)
values
  (1, 10, 'epic')
  , (1, 2, 'rare')
  , (1, 2, 'rare')
  , (1, 7, 'rare')
  , (1, 1, 'common')
  , (1, 2, 'common')
  , (1, 3, 'common')
  , (1, 5, 'common')
  , (1, 8, 'common')
  , (2, 8, 'epic')
  , (2, 5, 'rare')
  , (2, 3, 'common')
  , (2, 6, 'common');


-- Below query will give output as row wise but not concatenate the advised_name 
-- when username , type , quality are same .

select
  username
  , type
  , quality as advised_quality
  , name as advised_name
from
  accounts
  right join (
    select
      account_id
      , type
      , quality
      , name
      , dense_rank() over(
        partition by account_id
        , type
        order by
          field(quality, 'common', 'rare', 'epic') desc
      ) as seq
    from
      (
        select
          account_id
          , type
          , quality
          , name
        from
          accounts_items
          left join items
        on id = item_id
      ) as dummy
  ) as x
on id = account_id
where
  seq = 1
order by
  username
  , type;	
							

select
  *
from
  accounts_items;


with dummy1 as (
  select 
  ai.account_id as id , 
  a.username as username , 
  i.type as type , 
  ai.quality as quality , 
  i.name 
  from accounts_items as ai join items as i on ai.item_id = i.id 
  join accounts as a on a.id = ai.account_id 
) ,
dummy2 as(
    select 
    id ,
    username ,
    type ,
    quality as advised_quality ,
    dense_rank() over(partition by id , type order by field(quality, 'common', 'rare', 'epic') desc) as seq ,
    name 
    from dummy1
) ,

dummy3 as(
  select 
  id ,
  username ,
  type ,
  advised_quality ,
  group_concat(distinct name separator ',') as advised_name
  from dummy2
  where seq = 1 
  group by id , type , advised_quality
)

select 
username ,
type ,
advised_quality ,
advised_name 
from dummy3 ;

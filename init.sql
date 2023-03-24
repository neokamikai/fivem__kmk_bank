CREATE TABLE IF NOT EXISTS bank_transfer_targets (
  id bigint auto_increment,
  target_type varchar(30),
  target_id varchar(60),
  target_name varchar(60),
  primary key (id)
)
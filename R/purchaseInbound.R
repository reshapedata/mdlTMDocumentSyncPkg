#' wms按年月查询数据
#'
#' @param wms_token
#' @param fyear
#' @param fmonth
#'
#' @return
#' @export
#'
#' @examples
#' TmWMS_purchaseInbound_sekectBymonth()
TmWMS_purchaseInbound_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
a.id   ,
a.material_order_code	,
a.merchant_code	,
a.merchant_name	,
a.f_date	,
a.create_time	,
CASE   WHEN a.STATUS IN ('2', '4') THEN '已出库'   ELSE '执行中'  END AS f_status ,
b.sub_material_order_id ,
b.sub_custome_code	,
b.sub_material_code	,
b.sub_material_name	,
b.sub_material_type	,
b.sub_f_lot_fnumber	,
b.sub_f_material_model	,
b.sub_f_supplier_lot	,
b.sub_order_size	,
b.sub_f_act_receive_qty	,
b.sub_instore_num	,
b.sub_f_unit_name	,
b.sub_f_entry_status	,
c.material_order_detail_id	,
c.material_info_id	,
c.order_size	,
c.instore_num	,
c.create_time	,
c.material_code	,
c.material_name	,
c.material_unit	,
c.f_stock_id	,
c.create_user_name	,
c.f_lot_fnumber

from view_material_order as  a
inner join view_material_order_detail  b
on a.id = b.sub_material_order_id
inner join  view_material_instore_order_detail c
on  c.material_order_detail_id = b.sub_id
where YEAR(a.f_date) = '",fyear,"'
AND MONTH(a.f_date)='",fmonth,"' ")

  res <- tsda::mysql_select2(token =wms_token,sql = sql)

  return(res)

}



#' dms按年月删除数据
#'
#' @param wms_token
#' @param fyear
#' @param fmonth
#'
#' @return
#' @export
#'
#' @examples
#' TmWMS_purchaseInbound_deleteBymonth()
TmWMS_purchaseInbound_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_pur_instock
where YEAR(f_date) = '",fyear,"' AND MONTH(f_date )='",fmonth,"' ")

  res <- tsda::sql_delete2(token =dms_token,sql_str = sql)

  return(res)

}

#' dms按单据编号查询数据
#'
#' @param dms_token
#' @param fbillno
#'
#' @return
#' @export
#'
#' @examples
#' Tmdms_purchaseInbound_selectByfbillno()
Tmdms_purchaseInbound_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select id as 收料通知单主键ID,
material_order_code as 收料单号,
merchant_code as 供应商编号,
merchant_name as 供应商名称,
f_date as 收料日期,
f_create_time as 创建时间,
f_status as 状态,
sub_material_order_id as 收料通知单外键ID,
sub_custome_code as 供应商物料编码,
sub_material_code as 物料编码,
sub_material_name as 物料名称,
sub_material_type as 物料类型,
sub_f_lot_fnumber as 批号,
sub_f_material_model as 规格型号,
sub_f_supplier_lot as 供应商批号,
sub_order_size as 数量,
sub_f_act_receive_qty as 交货数量,
sub_instore_num as 实际采购入库数,
sub_f_unit_name as 单位,
sub_f_entry_status as 行状态,
material_order_detail_id as 关联收料单明细表id,
material_info_id as 物料id,
order_size as 要求收料数量,
instore_num as 实际入库数量,
create_time as 实际入库时间,
material_code as 物料编码,
material_name as 物料名称,
material_unit as 物料单位,
f_stock_id as ERP仓库代号,
create_user_name as 负责人,
f_lot_fnumber as 批号
from rds_dms_src_t_pur_instock
where material_order_code  = '",fbillno,"' ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




#' dms按日期查询数据
#'
#' @param dms_token
#' @param fdate
#'
#' @return
#' @export
#'
#' @examples
#' Tmdms_purchaseInbound_selectBydate()
Tmdms_purchaseInbound_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select id as 收料通知单主键ID,
material_order_code as 收料单号,
merchant_code as 供应商编号,
merchant_name as 供应商名称,
f_date as 收料日期,
f_create_time as 创建时间,
f_status as 状态,
sub_material_order_id as 收料通知单外键ID,
sub_custome_code as 供应商物料编码,
sub_material_code as 物料编码,
sub_material_name as 物料名称,
sub_material_type as 物料类型,
sub_f_lot_fnumber as 批号,
sub_f_material_model as 规格型号,
sub_f_supplier_lot as 供应商批号,
sub_order_size as 数量,
sub_f_act_receive_qty as 交货数量,
sub_instore_num as 实际采购入库数,
sub_f_unit_name as 单位,
sub_f_entry_status as 行状态,
material_order_detail_id as 关联收料单明细表id,
material_info_id as 物料id,
order_size as 要求收料数量,
instore_num as 实际入库数量,
create_time as 实际入库时间,
material_code as 物料编码,
material_name as 物料名称,
material_unit as 物料单位,
f_stock_id as ERP仓库代号,
create_user_name as 负责人,
f_lot_fnumber as 批号
from rds_dms_src_t_pur_instock
where CAST(f_date  AS date)  = '",fdate,"' ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}


#' dms按日期范围查询数据
#'
#' @param dms_token
#' @param fdate
#'
#' @return
#' @export
#'
#' @examples
#' Tmdms_purchaseInbound_selectBydateRange()
Tmdms_purchaseInbound_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select id as 收料通知单主键ID,
material_order_code as 收料单号,
merchant_code as 供应商编号,
merchant_name as 供应商名称,
f_date as 收料日期,
f_create_time as 创建时间,
f_status as 状态,
sub_material_order_id as 收料通知单外键ID,
sub_custome_code as 供应商物料编码,
sub_material_code as 物料编码,
sub_material_name as 物料名称,
sub_material_type as 物料类型,
sub_f_lot_fnumber as 批号,
sub_f_material_model as 规格型号,
sub_f_supplier_lot as 供应商批号,
sub_order_size as 数量,
sub_f_act_receive_qty as 交货数量,
sub_instore_num as 实际采购入库数,
sub_f_unit_name as 单位,
sub_f_entry_status as 行状态,
material_order_detail_id as 关联收料单明细表id,
material_info_id as 物料id,
order_size as 要求收料数量,
instore_num as 实际入库数量,
create_time as 实际入库时间,
material_code as 物料编码,
material_name as 物料名称,
material_unit as 物料单位,
f_stock_id as ERP仓库代号,
create_user_name as 负责人,
f_lot_fnumber as 批号
from rds_dms_src_t_pur_instock
where CAST(f_date  AS date) > ='",FStartDate,"' and CAST(f_date  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




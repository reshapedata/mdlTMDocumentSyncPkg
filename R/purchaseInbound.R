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
#' TmWMS_purchaseInbound_sekectAll()
TmWMS_purchaseInbound_sekectAll<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
a.id  as 收料通知单主键ID,
a.material_order_code	收料单号,
a.merchant_code	供应商编号,
a.merchant_name	供应商名称,
a.f_date	收料日期,
a.create_time	创建时间,
a.status	状态,
b.sub_material_order_id as 收料通知单外键ID,
b.sub_custome_code	供应商物料编码,
b.sub_material_code	物料编码,
b.sub_material_name	物料名称,
b.sub_material_type	物料类型,
b.sub_f_lot_fnumber	批号,
b.sub_f_material_model	规格型号,
b.sub_f_supplier_lot	供应商批号,
b.sub_order_size	数量,
b.sub_f_act_receive_qty	交货数量,
b.sub_instore_num	实际采购入库数,
b.sub_f_unit_name	单位,
b.sub_f_entry_status	行状态,
c.material_order_detail_id	关联收料单明细表id,
c.material_info_id	物料id,
c.order_size	要求收料数量,
c.instore_num	实际入库数量,
c.create_time	实际入库时间,
c.material_code	物料编码,
c.material_name	物料名称,
c.material_unit	物料单位,
c.f_stock_id	ERP仓库代号,
c.create_user_name	负责人,
c.f_lot_fnumber	批号
from view_material_order as  a
inner join view_material_order_detail  b
on a.id = b.sub_material_order_id
inner join  view_material_instore_order_detail c
on  c.material_order_detail_id = b.sub_id
where YEAR(a.create_time) = ‘",fyear,"’
AND MONTH(a.create_time)=‘",fmonth,"’")

  res <- tsda::sql_select2(token =wms_token,sql = sql )

  return(res)

}

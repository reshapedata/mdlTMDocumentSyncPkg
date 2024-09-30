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
#' TmWMS_saleOut_sekectBymonth()
TmWMS_saleOut_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
a.order_code	as order_code,
a.f_bill_no	as f_bill_no,
a.require_date	as require_date,
case a.type when '0' then 'AGV' else '人工' end  as f_type,
a.client_name	as client_name,
a.principle_user	as principle_user,
a.create_time	 as create_time,
b.sub_custome_code as sub_custome_code	,
b.sub_material_name	as sub_material_name,
b.sub_material_code	as sub_material_code,
b.sub_material_type as sub_material_type	,
b.sub_order_size as sub_order_size	,
b.sub_act_outstore_num	as sub_act_outstore_num,
b.sub_outstoring_num	as sub_outstoring_num,
b.sub_confirm_num as sub_confirm_num	,
b.sub_material_unit	as sub_material_unit,
c.order_id	as order_id,
c.order_detail_id	as order_detail_id,
c.material_id	as material_id,
c.package_code as package_code	,
c.num	as num,
CASE   WHEN c.STATUS IN ('2', '4') THEN '已出库'   ELSE '执行中'  END AS  f_status	,
c.material_code as material_code	,
c.material_name	as material_name,
c.material_unit	as material_unit,
c.location_id	as location_id,
c.outstore_time as outstore_time	,
c.confirm_user	as confirm_user,
c.confirm_time	aS confirm_time,
c.batch_number	AS batch_number,
c.number_str	AS number_str,
c.f_storck_id	AS f_storck_id,
c.outstore_user_name	AS outstore_user_name
from view_sale_shipment_order  as  a
inner join view_sale_shipment_order_detail  as b
on a.id = b.sub_order_id
inner join view_sale_shipment_material  as c
on c.order_id =  b.sub_order_id and c.order_detail_id = b.sub_id
where YEAR(c.outstore_time) = '",fyear,"'
AND MONTH(c.outstore_time)='",fmonth,"' ")

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
#' TmWMS_saleOut_deleteBymonth()
TmWMS_saleOut_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_sal_outstock
where YEAR(outstore_time) = '",fyear,"' AND MONTH(outstore_time)='",fmonth,"' ")

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
#' Tmdms_saleOut_selectByfbillno()
Tmdms_saleOut_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select  order_code	发货单号,
f_bill_no	ERP发货通知单号,
require_date	要求交期,
f_type as 	类型,
client_name	客户名称,
principle_user	负责人名称,
create_time	创建时间,
sub_custome_code	客户物料编号,
sub_material_name	物料名称,
sub_material_code	物料编码,
sub_material_type	物料类型,
sub_order_size	数量,
sub_act_outstore_num	实际出库量,
sub_outstoring_num	正在出库量,
sub_confirm_num	已确认发货量,
sub_material_unit	单位,
order_id	发货通知单id,
order_detail_id	发货通知单明细id,
material_id	物料id,
package_code	物料码ID,
num	实际出库数量,
f_status  状态,
material_code	物料编码,
material_name	物料名称,
material_unit	单位,
location_id	库位ID,
outstore_time	实际出库时间,
confirm_user	确认人,
confirm_time	确认发货时间,
batch_number	批次号,
number_str	流水号,
f_storck_id	ERP仓库代号,
outstore_user_name	出库人姓名
from rds_dms_src_t_sal_outstock
where f_bill_no = '",fbillno,"' ")

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
#' Tmdms_saleOut_selectBydate()
Tmdms_saleOut_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select  order_code	发货单号,
f_bill_no	ERP发货通知单号,
require_date	要求交期,
f_type as 	类型,
client_name	客户名称,
principle_user	负责人名称,
create_time	创建时间,
sub_custome_code	客户物料编号,
sub_material_name	物料名称,
sub_material_code	物料编码,
sub_material_type	物料类型,
sub_order_size	数量,
sub_act_outstore_num	实际出库量,
sub_outstoring_num	正在出库量,
sub_confirm_num	已确认发货量,
sub_material_unit	单位,
order_id	发货通知单id,
order_detail_id	发货通知单明细id,
material_id	物料id,
package_code	物料码ID,
num	实际出库数量,
f_status  状态,
material_code	物料编码,
material_name	物料名称,
material_unit	单位,
location_id	库位ID,
outstore_time	实际出库时间,
confirm_user	确认人,
confirm_time	确认发货时间,
batch_number	批次号,
number_str	流水号,
f_storck_id	ERP仓库代号,
outstore_user_name	出库人姓名
from rds_dms_src_t_sal_outstock
where CAST(outstore_time AS date) = '",fdate,"' ")

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
#' Tmdms_saleOut_selectBydateRange()
Tmdms_saleOut_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select  order_code	发货单号,
f_bill_no	ERP发货通知单号,
require_date	要求交期,
f_type as 	类型,
client_name	客户名称,
principle_user	负责人名称,
create_time	创建时间,
sub_custome_code	客户物料编号,
sub_material_name	物料名称,
sub_material_code	物料编码,
sub_material_type	物料类型,
sub_order_size	数量,
sub_act_outstore_num	实际出库量,
sub_outstoring_num	正在出库量,
sub_confirm_num	已确认发货量,
sub_material_unit	单位,
order_id	发货通知单id,
order_detail_id	发货通知单明细id,
material_id	物料id,
package_code	物料码ID,
num	实际出库数量,
f_status  状态,
material_code	物料编码,
material_name	物料名称,
material_unit	单位,
location_id	库位ID,
outstore_time	实际出库时间,
confirm_user	确认人,
confirm_time	确认发货时间,
batch_number	批次号,
number_str	流水号,
f_storck_id	ERP仓库代号,
outstore_user_name	出库人姓名
from rds_dms_src_t_sal_outstock
where CAST(outstore_time AS date) > ='",FStartDate,"' and CAST(outstore_time AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




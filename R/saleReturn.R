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
#' TmWMS_saleReturn_sekectBymonth()
TmWMS_saleReturn_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
a.f_bill_no,
a.f_bill_type_number,
a.f_bill_type_name,
a.f_date,
a.id,
a.order_code,
a.require_date,
case a.type when '0' then 'AGV' else '人工' end  f_type,
a.client_name,
a.principle_user,
a.principle_tel,
a.create_time,
a.create_user,
CASE   WHEN a.STATUS IN ('2', '4') THEN '已出库'   ELSE '执行中'  END AS f_STATUS ,
'' as  Return_Reason ,
b.sub_material_name,
b.sub_material_code,
b.sub_material_type,
b.sub_order_size,
b.sub_act_instore_num,
b.sub_material_unit,
'' as operate ,
c.order_id,
c.instore_time,
'' as  inoutstocktype,
'' as businesstype,
c.erp_warehouse_code,
c.location_id,
'' Container_number ,
'' as materialtype,
c.material_name,
c.material_code,
c.batch_number,
c.number_str,
c.num,
'' as  material_unit,
c.outstore_user_name,
'' materialstatus

from view_sale_return_order  a
INNER JOIN view_sale_return_order_detail b
on a.id = b.sub_order_id
left join  view_sale_return_material  c
on c.order_id =  b.sub_order_id
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
#' TmWMS_saleReturn_deleteBymonth()
TmWMS_saleReturn_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_sal_returnstock
where YEAR(f_date) = '",fyear,"' AND MONTH(f_date)='",fmonth,"' ")

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
#' Tmdms_saleReturn_selectByfbillno()
Tmdms_saleReturn_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select
f_bill_no as ERP退货通知单号,
f_bill_type_number as 单据类型编码,
f_bill_type_name as 单据类型名称,
f_date as 退货日期,
id as WMS退货通知单内码,
order_code as 退货单号,
require_date as 要求交期,
f_type as 类型,
client_name as 客户名称,
principle_user as 负责人名称,
principle_tel as 负责人电话,
create_time as 创建时间,
create_user as 创建人,
f_status as 状态 ,
Return_Reason as 退货原因,
sub_material_name as 物料名称,
sub_material_code as 物料编号,
sub_material_type as 物料类型,
sub_order_size as 数量,
sub_act_instore_num as 实际入库量,
sub_material_unit as 单位,
operate as 操作,
order_id as 退货通知单id,
instore_time as 出入库时间,
inoutstocktype as 出入库类型,
businesstype as 业务类型,
erp_warehouse_code as ERP仓库代号,
location_id as 库位ID,
Container_number as 容器编号,
materialtype as 物料类型,
material_name as 物料名称,
material_code as 物料编码,
batch_number as 批次号,
number_str as 流水号,
num as 实际出库数量,
material_unit as 单位,
outstore_user_name as 负责人,
materialstatus as 物料状态
from rds_dms_src_t_sal_returnstock
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
#' Tmdms_saleReturn_selectBydate()
Tmdms_saleReturn_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select
f_bill_no as ERP退货通知单号,
f_bill_type_number as 单据类型编码,
f_bill_type_name as 单据类型名称,
f_date as 退货日期,
id as WMS退货通知单内码,
order_code as 退货单号,
require_date as 要求交期,
f_type as 类型,
client_name as 客户名称,
principle_user as 负责人名称,
principle_tel as 负责人电话,
create_time as 创建时间,
create_user as 创建人,
f_status as 状态 ,
Return_Reason as 退货原因,
sub_material_name as 物料名称,
sub_material_code as 物料编号,
sub_material_type as 物料类型,
sub_order_size as 数量,
sub_act_instore_num as 实际入库量,
sub_material_unit as 单位,
operate as 操作,
order_id as 退货通知单id,
instore_time as 出入库时间,
inoutstocktype as 出入库类型,
businesstype as 业务类型,
erp_warehouse_code as ERP仓库代号,
location_id as 库位ID,
Container_number as 容器编号,
materialtype as 物料类型,
material_name as 物料名称,
material_code as 物料编码,
batch_number as 批次号,
number_str as 流水号,
num as 实际出库数量,
material_unit as 单位,
outstore_user_name as 负责人,
materialstatus as 物料状态
from rds_dms_src_t_sal_returnstock
where CAST(f_date AS date) = '",fdate,"' ")

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
#' Tmdms_saleReturn_selectBydateRange()
Tmdms_saleReturn_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select
f_bill_no as ERP退货通知单号,
f_bill_type_number as 单据类型编码,
f_bill_type_name as 单据类型名称,
f_date as 退货日期,
id as WMS退货通知单内码,
order_code as 退货单号,
require_date as 要求交期,
f_type as 类型,
client_name as 客户名称,
principle_user as 负责人名称,
principle_tel as 负责人电话,
create_time as 创建时间,
create_user as 创建人,
f_status as 状态 ,
Return_Reason as 退货原因,
sub_material_name as 物料名称,
sub_material_code as 物料编号,
sub_material_type as 物料类型,
sub_order_size as 数量,
sub_act_instore_num as 实际入库量,
sub_material_unit as 单位,
operate as 操作,
order_id as 退货通知单id,
instore_time as 出入库时间,
inoutstocktype as 出入库类型,
businesstype as 业务类型,
erp_warehouse_code as ERP仓库代号,
location_id as 库位ID,
Container_number as 容器编号,
materialtype as 物料类型,
material_name as 物料名称,
material_code as 物料编码,
batch_number as 批次号,
number_str as 流水号,
num as 实际出库数量,
material_unit as 单位,
outstore_user_name as 负责人,
materialstatus as 物料状态
from rds_dms_src_t_sal_returnstock
where CAST(f_date AS date) > ='",FStartDate,"' and CAST(f_date AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




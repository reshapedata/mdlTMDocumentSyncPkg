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
#' TmWMS_purchaseReturn_sekectBymonth()
TmWMS_purchaseReturn_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
a.f_bill_no,
a.f_bill_type_number,
a.f_bill_type_name,
a.f_date,
a.id,
a.return_order_code,
case a.type when '0' then 'AGV' else '人工' end  f_type,
a.travelling_merchant,
''  as  principle_user,
''   as  principle_tel,
a.create_time as f_create_time,
a.create_user,
CASE   WHEN a.STATUS IN ('2', '4') THEN '已出库'   ELSE '执行中'  END AS f_STATUS ,
b.sub_return_order_id,
b.sub_material_name,
b.sub_material_code,
b.sub_material_type,
b.sub_order_return_size,
b.sub_f_unit_name,
c.order_id,
c.create_time,
''  as inoutstocktype,
''  as  businesstype,
c.f_storck_id,
c.location_id,
c.f_material_type_id,
c.material_name,
c.material_code,
c.batch_number,
c.number_str,
c.num,
c.f_base_unit_name ,
c.create_user_name,
''  as materialstatus

from view_material_return_order  a
inner join   view_material_return_order_detail  as  b
on a.id = b.sub_return_order_id
left join view_material_return_outstore_detail c
on   c.order_detail_id  =   b.sub_return_order_id
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
#' TmWMS_purchaseReturn_deleteBymonth()
TmWMS_purchaseReturn_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_pur_mrb
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
#' Tmdms_purchaseReturn_selectByfbillno()
Tmdms_purchaseReturn_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select f_bill_no  as  单据编号,
f_bill_type_number  as  单据类型编码,
f_bill_type_name  as  单据类型,
f_date  as  收料日期,
id  as  序号,
return_order_code  as  退货单号,
f_type  as  类型,
travelling_merchant  as  供应商,
principle_user  as  负责人,
principle_tel  as  负责人电话,
create_time  as  创建时间,
create_user  as  创建人,
f_status  as  状态 ,
sub_return_order_id  as  退料通知单外键ID,
sub_material_name  as  物料名称,
sub_material_code  as  物料编码,
sub_material_type  as  物料类型,
sub_order_return_size  as  数量,
sub_f_unit_name  as  单位,
order_id  as  表头ID,
f_create_time  as  出入库时间,
inoutstocktype  as  出入库类型,
businesstype  as  业务类型,
f_storck_id  as  ERP仓库代号,
location_id  as  库位ID,
materialtype  as  物料类型,
material_name  as  物料名称,
material_code  as  物料编码,
batch_number  as  批号,
number_str  as  流水号,
num  as  实际退料数量,
unit  as  单位,
create_user_name  as  负责人,
materialstatus  as  物料状态
from rds_dms_src_t_pur_mrb
where return_order_code = '",fbillno,"' ")

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
#' Tmdms_purchaseReturn_selectBydate()
Tmdms_purchaseReturn_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select f_bill_no  as  单据编号,
f_bill_type_number  as  单据类型编码,
f_bill_type_name  as  单据类型,
f_date  as  收料日期,
id  as  序号,
return_order_code  as  退货单号,
f_type  as  类型,
travelling_merchant  as  供应商,
principle_user  as  负责人,
principle_tel  as  负责人电话,
create_time  as  创建时间,
create_user  as  创建人,
f_status  as  状态 ,
sub_return_order_id  as  退料通知单外键ID,
sub_material_name  as  物料名称,
sub_material_code  as  物料编码,
sub_material_type  as  物料类型,
sub_order_return_size  as  数量,
sub_f_unit_name  as  单位,
order_id  as  表头ID,
f_create_time  as  出入库时间,
inoutstocktype  as  出入库类型,
businesstype  as  业务类型,
f_storck_id  as  ERP仓库代号,
location_id  as  库位ID,
materialtype  as  物料类型,
material_name  as  物料名称,
material_code  as  物料编码,
batch_number  as  批号,
number_str  as  流水号,
num  as  实际退料数量,
unit  as  单位,
create_user_name  as  负责人,
materialstatus  as  物料状态
from rds_dms_src_t_pur_mrb
where CAST(f_date  AS date) = '",fdate,"' ")

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
#' Tmdms_purchaseReturn_selectBydateRange()
Tmdms_purchaseReturn_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select f_bill_no  as  单据编号,
f_bill_type_number  as  单据类型编码,
f_bill_type_name  as  单据类型,
f_date  as  收料日期,
id  as  序号,
return_order_code  as  退货单号,
f_type  as  类型,
travelling_merchant  as  供应商,
principle_user  as  负责人,
principle_tel  as  负责人电话,
create_time  as  创建时间,
create_user  as  创建人,
f_status  as  状态 ,
sub_return_order_id  as  退料通知单外键ID,
sub_material_name  as  物料名称,
sub_material_code  as  物料编码,
sub_material_type  as  物料类型,
sub_order_return_size  as  数量,
sub_f_unit_name  as  单位,
order_id  as  表头ID,
f_create_time  as  出入库时间,
inoutstocktype  as  出入库类型,
businesstype  as  业务类型,
f_storck_id  as  ERP仓库代号,
location_id  as  库位ID,
materialtype  as  物料类型,
material_name  as  物料名称,
material_code  as  物料编码,
batch_number  as  批号,
number_str  as  流水号,
num  as  实际退料数量,
unit  as  单位,
create_user_name  as  负责人,
materialstatus  as  物料状态
from rds_dms_src_t_pur_mrb
where CAST(f_date AS date) > ='",FStartDate,"' and CAST(f_date AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




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
#' TmWMS_saleOut_sekectAll()
TmWMS_saleOut_sekectAll<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
a.order_code	发货单号,
a.f_bill_no	ERP发货通知单号,
a.require_date	要求交期,
case a.type when '0' then 'AGV' else '人工' end as 	类型,
a.client_name	客户名称,
a.principle_user	负责人名称,
a.create_time	创建时间,
b.sub_custome_code	客户物料编号,
b.sub_material_name	物料名称,
b.sub_material_code	物料编码,
b.sub_material_type	物料类型,
b.sub_order_size	数量,
b.sub_act_outstore_num	实际出库量,
b.sub_outstoring_num	正在出库量,
b.sub_confirm_num	已确认发货量,
b.sub_material_unit	单位,
c.order_id	发货通知单id,
c.order_detail_id	发货通知单明细id,
c.material_id	物料id,
c.package_code	物料码ID,
c.num	实际出库数量,
c.status	状态,
c.material_code	物料编码,
c.material_name	物料名称,
c.material_unit	单位,
c.location_id	库位ID,
c.outstore_time	实际出库时间,
c.confirm_user	确认人,
c.confirm_time	确认发货时间,
c.batch_number	批次号,
c.number_str	流水号,
c.f_storck_id	ERP仓库代号,
c.outstore_user_name	出库人姓名
from view_sale_shipment_order  as  a
inner join view_sale_shipment_order_detail  as b
on a.id = b.sub_order_id
inner join view_sale_shipment_material  as c
on c.order_id =  b.sub_order_id and c.order_detail_id = b.sub_id
where YEAR(a.create_time) = ‘",fyear,"’
AND MONTH(a.create_time)=‘",fmonth,"’")

  res <- tsda::sql_select2(token =wms_token,sql = sql )

  return(res)

}


#' 销售出库上传至数据中台
#'
#' @param wms_token
#' @param dms_token
#'
#' @return
#' @export
#'
#' @examples
#' HourlyPiecerate_upload()
HourlyPiecerate_upload <- function(wms_token,dms_token) {


  data <- mdlTMDocumentSyncPkg::TmWMS_saleOut_sekectAll(wms_token =wms_token)
  # data = as.data.frame(data)
  #
  # data = tsdo::na_standard(data)
  #上传服务器----------------
    res=tsda::db_writeTable2(token = dms_token,table_name = '',r_object = data,append = TRUE)

  return(res)

  #end

}


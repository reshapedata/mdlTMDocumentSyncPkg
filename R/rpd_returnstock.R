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
#' TmWMS_rpd_returnstock_sekectBymonth()
TmWMS_rpd_returnstock_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("SELECT
'生产退库单'  as billtype ,
a.id ,
b.sub_id ,
f.product_instore_id ,
a.product_order_code ,
b.f_seq ,
a.batch_number as batch_number_head ,
a.f_bill_type ,
a.f_date ,
b.material_code   ,
b.batch_number  as  batch_number_entry ,
b.num as order_num ,
b.f_workshop_name ,
b.custome_code ,
b.custome_name ,
b.f_material_name ,
b.f_specification ,
b.f_unit_name ,
e.material_id ,
e.material_code ,
e.material_name ,
e.material_type_id ,
e.material_unit ,
e.out_num ,
e.waste_material_unit ,
e.type  as typeID ,
CASE WHEN e.type = '1' THEN '工程不良'
WHEN e.type = '2' THEN '质检不良'
 WHEN e.type = '3' THEN '超期库存'
WHEN e.type = '4' THEN '本工序_工程不良'
WHEN e.type = '5' THEN '本工序_质检不良'
WHEN e.type = '6' THEN '上工序_工程不良'
WHEN e.type = '7' THEN '上工序_质检不良' WHEN e.type = '8' THEN '水口' WHEN e.type = '9' THEN '料块' END AS Ftype ,
e.current_process  as current_processID ,
CASE WHEN e.current_process  = 'zz' THEN '组装线边库' WHEN e.current_process  = 'bm' THEN '宝马组装线边库'
WHEN e.current_process  = 'GP12' THEN 'GP12线边库' WHEN e.current_process  = 'zd' THEN '蒸镀线边库'
WHEN e.current_process  = 'uv' THEN 'uv线边库'  WHEN e.current_process  = 'zs' THEN '注塑线边库' END AS  current_process,
e.product_process as product_processID ,
CASE WHEN e.product_process  = 'zz' THEN '组装线边库'
WHEN e.product_process  = 'bm' THEN '宝马组装线边库'  WHEN e.product_process  = 'GP12' THEN 'GP12线边库'
WHEN e.product_process  = 'zd' THEN '蒸镀线边库' WHEN e.product_process  = 'uv' THEN 'uv线边库'
WHEN e.product_process  = 'zs' THEN '注塑线边库' END AS product_process,
e.current_f_storck_id ,
f.f_base_unit_name ,
f.num ,
f.batch_number ,
f.create_user_name ,
f.create_time

from view_pre_waste_order e
INNER JOIN view_pre_waste_order_detail f
on e.id = f.order_id
INNER JOIN view_product_order_detail b
on  f.product_order_detail_id  = b.sub_id and f.product_order_id = b.product_order_id
INNER JOIN view_product_order   a
on  b.product_order_id = a.id
where e.type in('5','6',5,6)
and  YEAR(f.create_time) = '",fyear,"'
AND MONTH(f.create_time )='",fmonth,"'
             ")

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
#' TmWMS_rpd_returnstock_deleteBymonth()
TmWMS_rpd_returnstock_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_rpd_returnstock
where YEAR(FcreateTime_scan) = '",fyear,"' AND MONTH(FcreateTime_scan )='",fmonth,"' ")

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
#' Tmdms_rpd_returnstock_selectByfbillno()
Tmdms_rpd_returnstock_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select  FBilltypeName	as	单据类型	,
FID	as	主键ID	,
FEntry	as	表体ID	,
FInstockID	as	生产入库单id	,
FBillNo	as	生产订单号	,
Fseq	as	物料id	,
FheadLot	as	包装码	,
FBillTypeID	as	单据类型编码	,
FDate	as	开工日期	,
FMaterialCode	as	调拨入ERP库区编号	,
Flot_entry	as	批次号	,
ForderQty	as	流水号	,
FWorkShopName	as	生产车间	,
FcustomerCode	as	客户编号	,
FCustomerName	as	客户名称	,
FMaterialName	as	订单物料名称	,
Fspecification	as	订单规格型号	,
FUnitName	as	订单单位名称	,
FMaterialID_order	as	扣减_订单物料id	,
FmaterialCode_order	as	扣减_订单物料编号	,
FMaterialName_order	as	扣减_订单物料名称	,
FMaterial_TypeID_order	as	扣减_订单物料类型id	,
FMaterialUnit_order	as	扣减_物料单位	,
FOutQty	as	扣减_物料重量	,
Funit_waste	as	废料单位	,
Ftype_wasteID	as	废料业务类型ID	,
Ftype_waste	as	废料业务类型	,
FCurrentProcessID	as	当前工序ID	,
FCurrentProcess	as	当前工序	,
FProductProcessID	as	责任工序ID	,
FProductProcess	as	责任工序	,
FFStorckID_waste	as	ERP仓库编号	,
Funit_scan	as	不良品基本单位	,
FProcessNGQty	as	本工序生产不良品数量	,
Flot_scan	as	不良品_批次号	,
Fcreator_scan	as	操作人姓名	,
FcreateTime_scan	as	操作时间
 from  rds_dms_src_t_rpd_returnstock
where FBillNo  = '",fbillno,"' ")

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
#' Tmdms_rpd_returnstock_selectBydate()
Tmdms_rpd_returnstock_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select  FBilltypeName	as	单据类型	,
FID	as	主键ID	,
FEntry	as	表体ID	,
FInstockID	as	生产入库单id	,
FBillNo	as	生产订单号	,
Fseq	as	物料id	,
FheadLot	as	包装码	,
FBillTypeID	as	单据类型编码	,
FDate	as	开工日期	,
FMaterialCode	as	调拨入ERP库区编号	,
Flot_entry	as	批次号	,
ForderQty	as	流水号	,
FWorkShopName	as	生产车间	,
FcustomerCode	as	客户编号	,
FCustomerName	as	客户名称	,
FMaterialName	as	订单物料名称	,
Fspecification	as	订单规格型号	,
FUnitName	as	订单单位名称	,
FMaterialID_order	as	扣减_订单物料id	,
FmaterialCode_order	as	扣减_订单物料编号	,
FMaterialName_order	as	扣减_订单物料名称	,
FMaterial_TypeID_order	as	扣减_订单物料类型id	,
FMaterialUnit_order	as	扣减_物料单位	,
FOutQty	as	扣减_物料重量	,
Funit_waste	as	废料单位	,
Ftype_wasteID	as	废料业务类型ID	,
Ftype_waste	as	废料业务类型	,
FCurrentProcessID	as	当前工序ID	,
FCurrentProcess	as	当前工序	,
FProductProcessID	as	责任工序ID	,
FProductProcess	as	责任工序	,
FFStorckID_waste	as	ERP仓库编号	,
Funit_scan	as	不良品基本单位	,
FProcessNGQty	as	本工序生产不良品数量	,
Flot_scan	as	不良品_批次号	,
Fcreator_scan	as	操作人姓名	,
FcreateTime_scan	as	操作时间
 from  rds_dms_src_t_rpd_returnstock
where CAST(FcreateTime_scan  AS date)  = '",fdate,"' ")

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
#' Tmdms_rpd_returnstock_selectBydateRange()
Tmdms_rpd_returnstock_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select  FBilltypeName	as	单据类型	,
FID	as	主键ID	,
FEntry	as	表体ID	,
FInstockID	as	生产入库单id	,
FBillNo	as	生产订单号	,
Fseq	as	物料id	,
FheadLot	as	包装码	,
FBillTypeID	as	单据类型编码	,
FDate	as	开工日期	,
FMaterialCode	as	调拨入ERP库区编号	,
Flot_entry	as	批次号	,
ForderQty	as	流水号	,
FWorkShopName	as	生产车间	,
FcustomerCode	as	客户编号	,
FCustomerName	as	客户名称	,
FMaterialName	as	订单物料名称	,
Fspecification	as	订单规格型号	,
FUnitName	as	订单单位名称	,
FMaterialID_order	as	扣减_订单物料id	,
FmaterialCode_order	as	扣减_订单物料编号	,
FMaterialName_order	as	扣减_订单物料名称	,
FMaterial_TypeID_order	as	扣减_订单物料类型id	,
FMaterialUnit_order	as	扣减_物料单位	,
FOutQty	as	扣减_物料重量	,
Funit_waste	as	废料单位	,
Ftype_wasteID	as	废料业务类型ID	,
Ftype_waste	as	废料业务类型	,
FCurrentProcessID	as	当前工序ID	,
FCurrentProcess	as	当前工序	,
FProductProcessID	as	责任工序ID	,
FProductProcess	as	责任工序	,
FFStorckID_waste	as	ERP仓库编号	,
Funit_scan	as	不良品基本单位	,
FProcessNGQty	as	本工序生产不良品数量	,
Flot_scan	as	不良品_批次号	,
Fcreator_scan	as	操作人姓名	,
FcreateTime_scan	as	操作时间
 from  rds_dms_src_t_rpd_returnstock
where CAST(FcreateTime_scan  AS date) > ='",FStartDate,"' and CAST(FcreateTime_scan  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




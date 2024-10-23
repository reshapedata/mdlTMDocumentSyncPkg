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
#' TmWMS_stk_miscellaneous_waste_sekectBymonth()
TmWMS_stk_miscellaneous_waste_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
'其他入库_废料入库'  as billtype ,
e.id as Fid ,
f.id as FEntryID ,
e.material_id ,
e.material_code ,
e.material_name ,
e.material_type_id ,
e.out_batch_number ,
e.material_unit ,
f.num ,
f.f_base_unit_name ,
f.batch_number ,
e.waste_material_id ,
e.waste_material_code ,
e.waste_material_name ,
e.waste_material_type_id ,
e.waste_f_storck_id ,
e.in_num ,
e.out_num ,
e.in_batch_number ,
e.waste_material_unit ,
e.type as FtypeID ,
CASE
		WHEN e.type = '1' THEN '工程不良'
		WHEN e.type = '2' THEN '质检不良'
		WHEN e.type = '3' THEN '超期库存'
		WHEN e.type = '4' THEN '本工序_工程不良'
		WHEN e.type = '5' THEN '本工序_质检不良'
		WHEN e.type = '6' THEN '上工序_工程不良'
		WHEN e.type = '7' THEN '上工序_质检不良'
		WHEN e.type = '8' THEN '水口'
		WHEN e.type = '9' THEN '料块'
END AS Ftype ,
CASE
		WHEN e.current_process  = 'zz' THEN '组装线边库'
		WHEN e.current_process  = 'bm' THEN '宝马组装线边库'
		WHEN e.current_process  = 'GP12' THEN 'GP12线边库'
		WHEN e.current_process  = 'zd' THEN '蒸镀线边库'
		WHEN e.current_process  = 'uv' THEN 'uv线边库'
		WHEN e.current_process  = 'zs' THEN '注塑线边库'
END AS current_process ,
CASE
		WHEN e.product_process  = 'zz' THEN '组装线边库'
		WHEN e.product_process  = 'bm' THEN '宝马组装线边库'
		WHEN e.product_process  = 'GP12' THEN 'GP12线边库'
		WHEN e.product_process  = 'zd' THEN '蒸镀线边库'
		WHEN e.product_process  = 'uv' THEN 'uv线边库'
		WHEN e.product_process  = 'zs' THEN '注塑线边库'
END AS product_process ,
e.current_f_storck_id ,
f.product_order_id ,
f.product_order_detail_id ,
f.create_user_name ,
f.create_time
from view_pre_waste_order e
INNER JOIN view_pre_waste_order_detail f
on e.id = f.order_id
WHERE (f.product_order_id IS NOT NULL OR e.type = '1')
and YEAR(f.create_time) = '",fyear,"'
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
#' TmWMS_stk_miscellaneous_waste_deleteBymonth()
TmWMS_stk_miscellaneous_waste_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_miscellaneous_waste
where YEAR(FcreateTime_scan  ) = '",fyear,"' AND MONTH(FcreateTime_scan  )='",fmonth,"' ")

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
#' Tmdms_stk_miscellaneous_waste_selectByfbillno()
Tmdms_stk_miscellaneous_waste_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select FBilltypeName	AS	单据类型	,
FID	AS	主键ID	,
FentryID	AS	表体ID	,
FMaterialID_order	AS	扣减_订单物料id	,
FmaterialCode_order	AS	扣减_订单物料编号	,
FMaterialName_order	AS	扣减_订单物料名称	,
FMaterial_TypeID_order	AS	扣减_订单物料类型id	,
Flot_waste	AS	扣减_订单物料批次	,
FMaterialUnit_order	AS	扣减_物料单位	,
FProcessNGQty	AS	本工序生产不良品数量	,
Funit_scan	AS	不良品基本单位	,
Flot_scan	AS	不良品_批次号	,
FMaterialID_waste	AS	废料id	,
FMaterialCode_waste	AS	废料编号	,
FMaterialName_waste	AS	废料名称	,
FMaterial_TypeID_waste	AS	废料类型id	,
FProwasteStockID	AS	粉碎前_入库仓库	,
FProwasterQty	AS	粉碎前_入库数量	,
FOutQty	AS	扣减_物料重量	,
FProwasterLot	AS	粉碎前_入库批次	,
Funit_waste	AS	废料单位	,
FtypeID	AS	废料业务类型id	,
Ftype_waste	AS	废料业务类型	,
FCurrentProcess	AS	当前工序	,
FProductProcess	AS	责任工序	,
FFStorckID_waste	AS	ERP仓库编号	,
FOrderID	AS	生产订单id	,
FOrdEntryID	AS	生产订单明细id	,
Fcreator_scan	AS	操作人姓名	,
FcreateTime_scan	AS	操作时间
 from rds_dms_src_t_stk_miscellaneous_waste
where FID  = '",fbillno,"' ")

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
#' Tmdms_stk_miscellaneous_waste_selectBydate()
Tmdms_stk_miscellaneous_waste_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select FBilltypeName	AS	单据类型	,
FID	AS	主键ID	,
FentryID	AS	表体ID	,
FMaterialID_order	AS	扣减_订单物料id	,
FmaterialCode_order	AS	扣减_订单物料编号	,
FMaterialName_order	AS	扣减_订单物料名称	,
FMaterial_TypeID_order	AS	扣减_订单物料类型id	,
Flot_waste	AS	扣减_订单物料批次	,
FMaterialUnit_order	AS	扣减_物料单位	,
FProcessNGQty	AS	本工序生产不良品数量	,
Funit_scan	AS	不良品基本单位	,
Flot_scan	AS	不良品_批次号	,
FMaterialID_waste	AS	废料id	,
FMaterialCode_waste	AS	废料编号	,
FMaterialName_waste	AS	废料名称	,
FMaterial_TypeID_waste	AS	废料类型id	,
FProwasteStockID	AS	粉碎前_入库仓库	,
FProwasterQty	AS	粉碎前_入库数量	,
FOutQty	AS	扣减_物料重量	,
FProwasterLot	AS	粉碎前_入库批次	,
Funit_waste	AS	废料单位	,
FtypeID	AS	废料业务类型id	,
Ftype_waste	AS	废料业务类型	,
FCurrentProcess	AS	当前工序	,
FProductProcess	AS	责任工序	,
FFStorckID_waste	AS	ERP仓库编号	,
FOrderID	AS	生产订单id	,
FOrdEntryID	AS	生产订单明细id	,
Fcreator_scan	AS	操作人姓名	,
FcreateTime_scan	AS	操作时间
 from rds_dms_src_t_stk_miscellaneous_waste
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
#' Tmdms_stk_miscellaneous_waste_selectBydateRange()
Tmdms_stk_miscellaneous_waste_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select FBilltypeName	AS	单据类型	,
FID	AS	主键ID	,
FentryID	AS	表体ID	,
FMaterialID_order	AS	扣减_订单物料id	,
FmaterialCode_order	AS	扣减_订单物料编号	,
FMaterialName_order	AS	扣减_订单物料名称	,
FMaterial_TypeID_order	AS	扣减_订单物料类型id	,
Flot_waste	AS	扣减_订单物料批次	,
FMaterialUnit_order	AS	扣减_物料单位	,
FProcessNGQty	AS	本工序生产不良品数量	,
Funit_scan	AS	不良品基本单位	,
Flot_scan	AS	不良品_批次号	,
FMaterialID_waste	AS	废料id	,
FMaterialCode_waste	AS	废料编号	,
FMaterialName_waste	AS	废料名称	,
FMaterial_TypeID_waste	AS	废料类型id	,
FProwasteStockID	AS	粉碎前_入库仓库	,
FProwasterQty	AS	粉碎前_入库数量	,
FOutQty	AS	扣减_物料重量	,
FProwasterLot	AS	粉碎前_入库批次	,
Funit_waste	AS	废料单位	,
FtypeID	AS	废料业务类型id	,
Ftype_waste	AS	废料业务类型	,
FCurrentProcess	AS	当前工序	,
FProductProcess	AS	责任工序	,
FFStorckID_waste	AS	ERP仓库编号	,
FOrderID	AS	生产订单id	,
FOrdEntryID	AS	生产订单明细id	,
Fcreator_scan	AS	操作人姓名	,
FcreateTime_scan	AS	操作时间
 from rds_dms_src_t_stk_miscellaneous_waste
where CAST(FcreateTime_scan  AS date) > ='",FStartDate,"' and CAST(FcreateTime_scan  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




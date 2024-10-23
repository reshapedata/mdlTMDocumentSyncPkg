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
#' TmWMS_stk_misdelivery_watste_sekectBymonth()
TmWMS_stk_misdelivery_watste_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("SELECT
'其他出库单_废料出库'  as billtype ,
g.id as Fid ,
g.outstore_group_id ,
g.CODE ,
g.raw_package_code ,
g.merchant_id ,
g.merchant_code ,
g.merchant_name ,
g.STATUS  as f_status ,
g.material_id ,
g.material_code ,
g.material_name ,
g.f_base_unit_name ,
g.num as waste_out_num  ,
g.material_type_code ,
g.material_type_name ,
g.batch_number ,
g.number_str ,
g.type as FtypeID  ,
CASE
		WHEN g.type = '1' THEN '待粉碎仓'
		WHEN g.type = '2' THEN '已粉碎仓'
		ELSE g.type
END AS Ftype  ,
g.erp_storck_code ,
g.location_id ,
g.outstore_type ,
g.remark ,
g.create_user ,
g.create_time ,
g.update_user ,
g.create_user_name ,
g.update_time
from view_waste_outstore_detail g
where YEAR(g.create_time) = '",fyear,"'
AND MONTH(g.create_time )='",fmonth,"'
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
#' TmWMS_stk_misdelivery_watste_deleteBymonth()
TmWMS_stk_misdelivery_watste_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_misdelivery_watste
where YEAR(FCreateTime) = '",fyear,"' AND MONTH(FCreateTime)='",fmonth,"' ")

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
#' Tmdms_stk_misdelivery_watste_selectByfbillno()
Tmdms_stk_misdelivery_watste_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("SELECT
FBilltypeName	as	单据类型	,
FID	as	废料出库主键id	,
FOutStockGroupID	as	出库组ID	,
FCode	as	出库码	,
FPackadeCode	as	追溯包装码	,
FSupplierID	as	供应商ID	,
FSupplierCode	as	供应商编码	,
FSupplierName	as	供应商名称	,
Fstatus	as	状态	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
Fqty	as	数量	,
FMaterialTypeCode	as	物料类型编码	,
FMaterialTypeName	as	物料类型	,
Flot	as	批次号	,
FFLow	as	流水号	,
FtypeID	as	类型ID	,,
Ftype	as	类型	,
FStockID	as	ERP库区编号	,
FStockLocID	as	库位id	,
FOutstoreType	as	出库类型	,
FRemark	as	类型标识	,
FcreatorID	as	创建人	,
FCreateTime	as	创建时间	,
FUpdater	as	更新人	,
FCreatorName	as	创建人姓名	,
FUpdateTime	as	更新时间
from rds_dms_src_t_stk_misdelivery_watste
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
#' Tmdms_stk_misdelivery_watste_selectBydate()
Tmdms_stk_misdelivery_watste_selectBydate<- function(dms_token,fdate) {
  sql=paste0("SELECT
FBilltypeName	as	单据类型	,
FID	as	废料出库主键id	,
FOutStockGroupID	as	出库组ID	,
FCode	as	出库码	,
FPackadeCode	as	追溯包装码	,
FSupplierID	as	供应商ID	,
FSupplierCode	as	供应商编码	,
FSupplierName	as	供应商名称	,
Fstatus	as	状态	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
Fqty	as	数量	,
FMaterialTypeCode	as	物料类型编码	,
FMaterialTypeName	as	物料类型	,
Flot	as	批次号	,
FFLow	as	流水号	,
FtypeID	as	类型ID	,	,
Ftype	as	类型	,
FStockID	as	ERP库区编号	,
FStockLocID	as	库位id	,
FOutstoreType	as	出库类型	,
FRemark	as	类型标识	,
FcreatorID	as	创建人	,
FCreateTime	as	创建时间	,
FUpdater	as	更新人	,
FCreatorName	as	创建人姓名	,
FUpdateTime	as	更新时间
from rds_dms_src_t_stk_misdelivery_watste
where CAST(FCreateTime  AS date)  = '",fdate,"' ")

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
#' Tmdms_stk_misdelivery_watste_selectBydateRange()
Tmdms_stk_misdelivery_watste_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("SELECT
FBilltypeName	as	单据类型	,
FID	as	废料出库主键id	,
FOutStockGroupID	as	出库组ID	,
FCode	as	出库码	,
FPackadeCode	as	追溯包装码	,
FSupplierID	as	供应商ID	,
FSupplierCode	as	供应商编码	,
FSupplierName	as	供应商名称	,
Fstatus	as	状态	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
Fqty	as	数量	,
FMaterialTypeCode	as	物料类型编码	,
FMaterialTypeName	as	物料类型	,
Flot	as	批次号	,
FFLow	as	流水号	,
FtypeID	as	类型ID	,	,
Ftype	as	类型	,
FStockID	as	ERP库区编号	,
FStockLocID	as	库位id	,
FOutstoreType	as	出库类型	,
FRemark	as	类型标识	,
FcreatorID	as	创建人	,
FCreateTime	as	创建时间	,
FUpdater	as	更新人	,
FCreatorName	as	创建人姓名	,
FUpdateTime	as	更新时间
from rds_dms_src_t_stk_misdelivery_watste
where CAST(FCreateTime  AS date) > ='",FStartDate,"' and CAST(FCreateTime  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




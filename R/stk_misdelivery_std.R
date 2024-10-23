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
#' TmWMS_stk_misdelivery_std_sekectBymonth()
TmWMS_stk_misdelivery_std_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("SELECT
'其他出库单_std'  as billtype ,
n.id ,
n.type ,
CASE
		WHEN n.type = '26' THEN '其他入库'
		WHEN n.type = '27' THEN '其他出库'
END AS FtypName ,
n.in_out_flag ,
CASE
		WHEN n.in_out_flag = '1' THEN '入库'
		WHEN n.in_out_flag = '0' THEN  '出库'
END AS in_out_flag_name ,
n.remark ,
n.package_code ,
n.material_id ,
n.material_code ,
n.material_name ,
n.num ,
n.f_base_unit_name ,
n.batch_number ,
n.erp_area_code ,
n.location_id ,
n.update_user ,
n.number_str ,
n.opera_user_name ,
n.update_time

from view_other_in_out_record  n
where n.type ='27'
and YEAR(n.update_time) = '",fyear,"'
AND MONTH(n.update_time )='",fmonth,"'
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
#' TmWMS_stk_misdelivery_std_deleteBymonth()
TmWMS_stk_misdelivery_std_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_misdelivery_std
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
#' Tmdms_stk_misdelivery_std_selectByfbillno()
Tmdms_stk_misdelivery_std_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select
FBilltypeName	as	单据类型	,
FID	as	主键id	,
Ftypeid	as	业务类型	,
Ftype	as	业务类型	,
FInOutFlagID	as	出入库标识	,
FInOutFlag	as	出入库标识	,
FRemark	as	类型标识	,
FPackadeCode	as	包装码	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterilName	as	物料名称	,
Fqty	as	数量	,
Funit	as	单位	,
Flot	as	批次号	,
FStockID	as	ERP库区编号	,
FStockLocID	as	库位id	,
Fcreator	as	更新人ID	,
FFlowNo	as	流水号	,
FStoker	as	操作人姓名	,
FCreateTime	as	出入库时间
from rds_dms_src_t_stk_misdelivery_std
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
#' Tmdms_stk_misdelivery_std_selectBydate()
Tmdms_stk_misdelivery_std_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select
FBilltypeName	as	单据类型	,
FID	as	主键id	,
Ftypeid	as	业务类型	,
Ftype	as	业务类型	,
FInOutFlagID	as	出入库标识	,
FInOutFlag	as	出入库标识	,
FRemark	as	类型标识	,
FPackadeCode	as	包装码	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterilName	as	物料名称	,
Fqty	as	数量	,
Funit	as	单位	,
Flot	as	批次号	,
FStockID	as	ERP库区编号	,
FStockLocID	as	库位id	,
Fcreator	as	更新人ID	,
FFlowNo	as	流水号	,
FStoker	as	操作人姓名	,
FCreateTime	as	出入库时间
from rds_dms_src_t_stk_misdelivery_std
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
#' Tmdms_stk_misdelivery_std_selectBydateRange()
Tmdms_stk_misdelivery_std_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select
FBilltypeName	as	单据类型	,
FID	as	主键id	,
Ftypeid	as	业务类型	,
Ftype	as	业务类型	,
FInOutFlagID	as	出入库标识	,
FInOutFlag	as	出入库标识	,
FRemark	as	类型标识	,
FPackadeCode	as	包装码	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterilName	as	物料名称	,
Fqty	as	数量	,
Funit	as	单位	,
Flot	as	批次号	,
FStockID	as	ERP库区编号	,
FStockLocID	as	库位id	,
Fcreator	as	更新人ID	,
FFlowNo	as	流水号	,
FStoker	as	操作人姓名	,
FCreateTime	as	出入库时间
from rds_dms_src_t_stk_misdelivery_std
where CAST(FCreateTime  AS date) > ='",FStartDate,"' and CAST(FCreateTime  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




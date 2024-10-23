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
#' TmWMS_stk_stktransferin_others_sekectBymonth()
TmWMS_stk_stktransferin_others_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("SELECT
'直接调拨_其他'  as billtype ,
t.id as  FID ,
t.task_id as  FTaskID ,
t.type as  FtypeID ,
CASE
		WHEN t.type = '17' THEN '销售发货拆箱出库'
		WHEN t.type = '17-2' THEN '销售发货拆箱回库'
		WHEN t.type = '18' THEN '质检出库'
		WHEN t.type = '22' THEN '半箱出库'
		ELSE t.type
END AS Ftype ,
t.package_code as  FPackadeCode ,
t.material_id as  FMaterialID ,
t.material_code as  FMaterialCode ,
t.material_name as  FMaterialName ,
t.f_base_unit_name as  Funit ,
t.batch_number as  Flot ,
t.erp_storck_id as  FStockID_out ,
t.location_id as  FStockLocID_out ,
t.create_user as  FCreatorID_out ,
t.opera_user_name as  FCrteatorName_out ,
t.number_str as  FFlowNo_out ,
t.opera_time as  FCreateTime_out ,
abs(t.num) as  Fqty ,
w.erp_storck_id as  FStockID_in ,
w.location_id as  FStockLocID_in ,
w.create_user as  FCreatorID_in ,
w.opera_user_name as  FCrteatorName_in ,
w.number_str as  FFlowNo_in ,
w.opera_time as  FCreateTime_in
FROM   view_wms_inventory_record AS t
INNER JOIN    view_wms_inventory_record AS w
ON     t.task_id = w.task_id
WHERE  t.in_out_flag = '0' AND w.in_out_flag = '1' and w.erp_storck_id <> t.erp_storck_id
and YEAR(w.opera_time) = '",fyear,"'
AND MONTH(w.opera_time )='",fmonth,"'
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
#' TmWMS_stk_stktransferin_others_deleteBymonth()
TmWMS_stk_stktransferin_others_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_stktransferin_others
where YEAR(FCreateTime_in) = '",fyear,"' AND MONTH(FCreateTime_in)='",fmonth,"' ")

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
#' Tmdms_stk_stktransferin_others_selectByfbillno()
Tmdms_stk_stktransferin_others_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select  FBilltypeName	as	单据类型	,
FID	as	主键id	,
FTaskID	as	任务id	,
Ftypeid	as	业务类型id	,
Ftype	as	业务类型	,
FPackadeCode	as	包装码	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
Flot	as	批次号	,
FStockID_out	as	调拨出仓库编号	,
FStockLocID_out	as	调拨出库位id	,
FCreatorID_out	as	调拨出创建人ID	,
FCrteatorName_out	as	调拨出操作人姓名	,
FFlowNo_out	as	调拨出流水号	,
FCreateTime_out	as	调拨出操作时间	,
Fqty	as	数量	,
FStockID_in	as	调拨入仓库区编号	,
FStockLocID_in	as	调拨入库位id	,
FCreatorID_in	as	调拨入创建人ID	,
FCrteatorName_in	as	调拨入操作人姓名	,
FFlowNo_in	as	调拨入流水号	,
FCreateTime_in	as	调拨入操作时间
 from  rds_dms_src_t_stk_stktransferin_others
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
#' Tmdms_stk_stktransferin_others_selectBydate()
Tmdms_stk_stktransferin_others_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select  FBilltypeName	as	单据类型	,
FID	as	主键id	,
FTaskID	as	任务id	,
Ftypeid	as	业务类型id	,
Ftype	as	业务类型	,
FPackadeCode	as	包装码	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
Flot	as	批次号	,
FStockID_out	as	调拨出仓库编号	,
FStockLocID_out	as	调拨出库位id	,
FCreatorID_out	as	调拨出创建人ID	,
FCrteatorName_out	as	调拨出操作人姓名	,
FFlowNo_out	as	调拨出流水号	,
FCreateTime_out	as	调拨出操作时间	,
Fqty	as	数量	,
FStockID_in	as	调拨入仓库区编号	,
FStockLocID_in	as	调拨入库位id	,
FCreatorID_in	as	调拨入创建人ID	,
FCrteatorName_in	as	调拨入操作人姓名	,
FFlowNo_in	as	调拨入流水号	,
FCreateTime_in	as	调拨入操作时间
 from  rds_dms_src_t_stk_stktransferin_others
where CAST(FCreateTime_in  AS date)  = '",fdate,"' ")

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
#' Tmdms_stk_stktransferin_others_selectBydateRange()
Tmdms_stk_stktransferin_others_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select  FBilltypeName	as	单据类型	,
FID	as	主键id	,
FTaskID	as	任务id	,
Ftypeid	as	业务类型id	,
Ftype	as	业务类型	,
FPackadeCode	as	包装码	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
Flot	as	批次号	,
FStockID_out	as	调拨出仓库编号	,
FStockLocID_out	as	调拨出库位id	,
FCreatorID_out	as	调拨出创建人ID	,
FCrteatorName_out	as	调拨出操作人姓名	,
FFlowNo_out	as	调拨出流水号	,
FCreateTime_out	as	调拨出操作时间	,
Fqty	as	数量	,
FStockID_in	as	调拨入仓库区编号	,
FStockLocID_in	as	调拨入库位id	,
FCreatorID_in	as	调拨入创建人ID	,
FCrteatorName_in	as	调拨入操作人姓名	,
FFlowNo_in	as	调拨入流水号	,
FCreateTime_in	as	调拨入操作时间
 from  rds_dms_src_t_stk_stktransferin_others
where CAST(FCreateTime_in  AS date) > ='",FStartDate,"' and CAST(FCreateTime_in  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




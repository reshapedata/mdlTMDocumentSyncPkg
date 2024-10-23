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
#' TmWMS_stk_stktransferin_std_sekectBymonth()
TmWMS_stk_stktransferin_std_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("SELECT
'直接调拨_退料'  as billtype ,
s.id as  FID ,
s.transport_id as  FTransportID ,
s.package_code as  FPackadeCode ,
s.material_id as  FMatrialID ,
s.material_code as  FMaterialCode ,
s.material_name as  FMaterialName ,
s.f_base_unit_name as  Funit ,
s.start_erp_area_code as  FStockArea_start ,
s.location_start as  FStockLocID_start ,
s.num as  Fqty ,
s.end_erp_area_code as  FStockArea_end ,
s.location_end as  FStockLocID_end ,
s.batch_number as  Flot ,
s.number_str as  FFlowNo ,
s.update_user as  FUpdaterID ,
s.update_user_name as  FUpdateName ,
s.update_time as  FUpdateTime

from view_transport_aux_material s
where YEAR(s.update_time) = '",fyear,"'
AND MONTH(s.update_time )='",fmonth,"'
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
#' TmWMS_stk_stktransferin_std_deleteBymonth()
TmWMS_stk_stktransferin_std_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_stktransferin_std
where YEAR(FUpdateTime) = '",fyear,"' AND MONTH(FUpdateTime)='",fmonth,"' ")

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
#' Tmdms_stk_stktransferin_std_selectByfbillno()
Tmdms_stk_stktransferin_std_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select FBilltypeName	as	单据类型	,
FID	as	主键	,
FTransportID	as	关系键	,
FPackadeCode	as	包装码	,
FMatrialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
FStockArea_start	as	调拨出库区ERP编号	,
FStockLocID_start	as	调拨出库位id	,
Fqty	as	数量	,
FStockArea_end	as	调拨入库区ERP编号	,
FStockLocID_end	as	调拨入库位id	,
Flot	as	批次号	,
FFlowNo	as	流水号	,
FUpdaterID	as	最后修改人	,
FUpdateName	as	最后修改人姓名	,
FUpdateTime	as	最后修改时间
from
rds_dms_src_t_stk_stktransferin_std
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
#' Tmdms_stk_stktransferin_std_selectBydate()
Tmdms_stk_stktransferin_std_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select FBilltypeName	as	单据类型	,
FID	as	主键	,
FTransportID	as	关系键	,
FPackadeCode	as	包装码	,
FMatrialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
FStockArea_start	as	调拨出库区ERP编号	,
FStockLocID_start	as	调拨出库位id	,
Fqty	as	数量	,
FStockArea_end	as	调拨入库区ERP编号	,
FStockLocID_end	as	调拨入库位id	,
Flot	as	批次号	,
FFlowNo	as	流水号	,
FUpdaterID	as	最后修改人	,
FUpdateName	as	最后修改人姓名	,
FUpdateTime	as	最后修改时间
from
rds_dms_src_t_stk_stktransferin_std
where CAST(FUpdateTime  AS date)  = '",fdate,"' ")

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
#' Tmdms_stk_stktransferin_std_selectBydateRange()
Tmdms_stk_stktransferin_std_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select FBilltypeName	as	单据类型	,
FID	as	主键	,
FTransportID	as	关系键	,
FPackadeCode	as	包装码	,
FMatrialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
FStockArea_start	as	调拨出库区ERP编号	,
FStockLocID_start	as	调拨出库位id	,
Fqty	as	数量	,
FStockArea_end	as	调拨入库区ERP编号	,
FStockLocID_end	as	调拨入库位id	,
Flot	as	批次号	,
FFlowNo	as	流水号	,
FUpdaterID	as	最后修改人	,
FUpdateName	as	最后修改人姓名	,
FUpdateTime	as	最后修改时间
from
rds_dms_src_t_stk_stktransferin_std
where CAST(FUpdateTime  AS date) > ='",FStartDate,"' and CAST(FUpdateTime  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




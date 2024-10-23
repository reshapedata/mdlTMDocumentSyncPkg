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
#' TmWMS_stk_stktransferin_material_sekectBymonth()
TmWMS_stk_stktransferin_material_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("SELECT
'直接调拨单_物料'  as billtype ,
r.id as FID  ,
r.transfer_detail_id as FID_transfer  ,
r.transfer_id as FEntryID_transfer  ,
r.date_str as Fdate_str  ,
r.use_material_list_id as FPPbomID  ,
r.package_code as FPackadeCode  ,
r.material_id as FMaterialID  ,
r.material_code as FMaterialCode  ,
r.material_name as FMaterialName  ,
r.f_base_unit_name as Funit  ,
r.erp_start_storck_code as FStockID_start  ,
r.transfer_area_start as FStockAreaStart  ,
r.location_start as FStockLocID_start  ,
r.f_lot as Flot_start  ,
r.transfer_start_user_name as FTransferName_start  ,
r.transfer_start_user as FTransferName_start  ,
r.transfer_start_time as FTransferName_start  ,
r.num as FQTY  ,
r.erp_end_storck_code as FStockID_end  ,
r.location_end as FStockLocID_end  ,
r.batch_number as Flot_end  ,
r.f_entry_id as FEntryID  ,
r.number_str as FFLowNo  ,
r.transfer_end_user_name as FTransferName_end  ,
r.transfer_end_user as FTransferName_end  ,
r.transfer_area_end as FStockAreaENd  ,
r.transfer_end_time as FTransferName_end
from view_transfer_material r
where YEAR(r.transfer_end_time) = '",fyear,"'
AND MONTH(r.transfer_end_time )='",fmonth,"'
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
#' TmWMS_stk_stktransferin_material_deleteBymonth()
TmWMS_stk_stktransferin_material_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_stktransferin_material
where YEAR(FTransferTime_end) = '",fyear,"' AND MONTH(FTransferTime_end)='",fmonth,"' ")

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
#' Tmdms_stk_stktransferin_material_selectByfbillno()
Tmdms_stk_stktransferin_material_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select FBilltypeName	as	单据类型	,
FID	as	主键	,
FID_transfer	as	调拨单id	,
FEntryID_transfer	as	调拨单明细id	,
Fdate_str	as	开工日期	,
FPPbomID	as	用料清单id	,
FPackadeCode	as	包装码	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
FStockID_start	as	调拨出ERP库区编号	,
FStockAreaStart	as	调拨出库区id	,
FStockLocID_start	as	调拨出库位id	,
Flot_start	as	批号	,
FTransferName_start	as	调拨出操作人	,
FTransferIDstart	as	调拨出负责人	,
FTransferTime_start	as	调拨出时间	,
FQTY	as	数量	,
FStockID_end	as	调拨入ERP库区编号	,
FStockLocID_end	as	调拨入库位id	,
Flot_end	as	批次号	,
FEntryID	as	分录内码	,
FFLowNo	as	流水号	,
FTransferName_end	as	调拨入操作人	,
FTransferID_end	as	调拨入负责人	,
FStockAreaENd	as	调拨入库区id	,
FTransferTime_end	as	调拨入时间
 from   rds_dms_src_t_stk_stktransferin_material
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
#' Tmdms_stk_stktransferin_material_selectBydate()
Tmdms_stk_stktransferin_material_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select FBilltypeName	as	单据类型	,
FID	as	主键	,
FID_transfer	as	调拨单id	,
FEntryID_transfer	as	调拨单明细id	,
Fdate_str	as	开工日期	,
FPPbomID	as	用料清单id	,
FPackadeCode	as	包装码	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
FStockID_start	as	调拨出ERP库区编号	,
FStockAreaStart	as	调拨出库区id	,
FStockLocID_start	as	调拨出库位id	,
Flot_start	as	批号	,
FTransferName_start	as	调拨出操作人	,
FTransferIDstart	as	调拨出负责人	,
FTransferTime_start	as	调拨出时间	,
FQTY	as	数量	,
FStockID_end	as	调拨入ERP库区编号	,
FStockLocID_end	as	调拨入库位id	,
Flot_end	as	批次号	,
FEntryID	as	分录内码	,
FFLowNo	as	流水号	,
FTransferName_end	as	调拨入操作人	,
FTransferID_end	as	调拨入负责人	,
FStockAreaENd	as	调拨入库区id	,
FTransferTime_end	as	调拨入时间
 from   rds_dms_src_t_stk_stktransferin_material
where CAST(FTransferTime_end  AS date)  = '",fdate,"' ")

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
#' Tmdms_stk_stktransferin_material_selectBydateRange()
Tmdms_stk_stktransferin_material_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select FBilltypeName	as	单据类型	,
FID	as	主键	,
FID_transfer	as	调拨单id	,
FEntryID_transfer	as	调拨单明细id	,
Fdate_str	as	开工日期	,
FPPbomID	as	用料清单id	,
FPackadeCode	as	包装码	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
Funit	as	单位	,
FStockID_start	as	调拨出ERP库区编号	,
FStockAreaStart	as	调拨出库区id	,
FStockLocID_start	as	调拨出库位id	,
Flot_start	as	批号	,
FTransferName_start	as	调拨出操作人	,
FTransferIDstart	as	调拨出负责人	,
FTransferTime_start	as	调拨出时间	,
FQTY	as	数量	,
FStockID_end	as	调拨入ERP库区编号	,
FStockLocID_end	as	调拨入库位id	,
Flot_end	as	批次号	,
FEntryID	as	分录内码	,
FFLowNo	as	流水号	,
FTransferName_end	as	调拨入操作人	,
FTransferID_end	as	调拨入负责人	,
FStockAreaENd	as	调拨入库区id	,
FTransferTime_end	as	调拨入时间
 from   rds_dms_src_t_stk_stktransferin_material
where CAST(FTransferTime_end  AS date) > ='",FStartDate,"' and CAST(FTransferTime_end  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




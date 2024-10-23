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
#' TmWMS_productWarehousing_sekectBymonth()
TmWMS_productWarehousing_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
a.id ,
b.sub_id ,
'生产订单'  as billtype ,
a.product_order_code ,
b.f_seq ,
a.batch_number as batch_number_head ,
CASE
		WHEN a.f_document_status = 'A' THEN '创建'
		WHEN a.f_document_status = 'B' THEN '审核中'
		WHEN a.f_document_status = 'C' THEN '已审核'
		WHEN a.f_document_status = 'D' THEN '重新审核'
		WHEN a.f_document_status = 'Z' THEN '暂存'
		ELSE ''
END AS f_document_status ,
a.f_bill_type ,
a.f_date ,
a.f_bill_no ,
b.material_code   ,
b.batch_number  as  batch_number_entry ,
b.num as order_num ,
CASE   WHEN b.STATUS IN ('2', '4') THEN '已出库'   ELSE '执行中'  END AS FStatus ,
b.create_time  as  create_time_head ,
b.f_workshop_name ,
b.custome_code ,
b.custome_name ,
b.f_entry_id  as f_entry_id_entry,
b.f_material_name ,
b.f_specification ,
b.f_unit_name ,
b.f_rds_classes_number ,
b.f_rds_classes_name ,
b.act_instore_num ,
b.ready_confirm_num ,
c.material_code as material_code_instock ,
c.material_name ,
c.material_unit ,
c.f_storck_id_number ,
c.num as instock_num ,
c.f_storck_id ,
c.erp_order_code ,
c.create_time  as create_time_stock ,
c.create_user_name

from view_product_instore_detail c
INNER JOIN view_product_order_detail b
on  c.order_detail_id = b.sub_id and c.order_id = b.product_order_id
INNER JOIN view_product_order   a
on  b.product_order_id = a.id
where YEAR(c.create_time) = '",fyear,"'
AND MONTH(c.create_time )='",fmonth,"'
and  a.f_date is NOT NULL and c.erp_order_code is NULL
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
#' TmWMS_productWarehousing_deleteBymonth()
TmWMS_productWarehousing_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_prd_instock
where YEAR(FInstockTime) = '",fyear,"' AND MONTH(FInstockTime )='",fmonth,"' ")

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
#' Tmdms_productWarehousing_selectByfbillno()
Tmdms_productWarehousing_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("SELECT
FID	 as 	主键ID	,
FSubID	 as 	表体ID	,
FBilltypeName	 as 	单据类型名称	,
FBillNo	 as 	单据编号	,
Fseq	 as 	订单行号	,
FheadLot	 as 	订单表头批号	,
FDocumentStatus	 as 	单据状态	,
FBillTypeID	 as 	单据类型编码	,
Fdate	 as 	单据日期	,
FBillNoSource	 as 	订单单据编号	,
FMaterialCode	 as 	物料编码	,
Flot_entry	 as 	订单分录批号	,
ForderQty	 as 	订单数量	,
Fstatus_entry	 as 	订单状态	,
FCreateDate_entry	 as 	订单日期	,
FWorkShopName	 as 	生产车间	,
FcustomerCode	 as 	客户编号	,
FCustomerName	 as 	客户名称	,
FEntryID	 as 	订单分录ID	,
FMaterialName	 as 	订单物料名称	,
Fspecification	 as 	订单规格型号	,
FUnitName	 as 	订单单位名称	,
F_rds_ClassesCode	 as 	班次编码	,
F_rds_ClassesName	 as 	班次	,
FRealInstockQyt	 as 	实际入库数量	,
FConfirmInstockQty	 as 	待确认入库数量	,
FMaterialCode_instore	 as 	入库物料编码	,
FMaterialName_instore	 as 	入库物料名称	,
FMaterialUnit_instore	 as 	入库物料单位	,
Flot_instore	 as 	入库批号	,
Fqty_EntryQty	 as 	入库数量	,
FStockID	 as 	入库仓库代号	,
FInstockBillNo	 as 	入库单编号	,
FInstockTime	 as 	入库时间	,
Fstocker	 as 	仓管员
FROM  rds_dms_src_t_prd_instock
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
#' Tmdms_productWarehousing_selectBydate()
Tmdms_productWarehousing_selectBydate<- function(dms_token,fdate) {
  sql=paste0("SELECT
FID	 as 	主键ID	,
FSubID	 as 	表体ID	,
FBilltypeName	 as 	单据类型名称	,
FBillNo	 as 	单据编号	,
Fseq	 as 	订单行号	,
FheadLot	 as 	订单表头批号	,
FDocumentStatus	 as 	单据状态	,
FBillTypeID	 as 	单据类型编码	,
Fdate	 as 	单据日期	,
FBillNoSource	 as 	订单单据编号	,
FMaterialCode	 as 	物料编码	,
Flot_entry	 as 	订单分录批号	,
ForderQty	 as 	订单数量	,
Fstatus_entry	 as 	订单状态	,
FCreateDate_entry	 as 	订单日期	,
FWorkShopName	 as 	生产车间	,
FcustomerCode	 as 	客户编号	,
FCustomerName	 as 	客户名称	,
FEntryID	 as 	订单分录ID	,
FMaterialName	 as 	订单物料名称	,
Fspecification	 as 	订单规格型号	,
FUnitName	 as 	订单单位名称	,
F_rds_ClassesCode	 as 	班次编码	,
F_rds_ClassesName	 as 	班次	,
FRealInstockQyt	 as 	实际入库数量	,
FConfirmInstockQty	 as 	待确认入库数量	,
FMaterialCode_instore	 as 	入库物料编码	,
FMaterialName_instore	 as 	入库物料名称	,
FMaterialUnit_instore	 as 	入库物料单位	,
Flot_instore	 as 	入库批号	,
Fqty_EntryQty	 as 	入库数量	,
FStockID	 as 	入库仓库代号	,
FInstockBillNo	 as 	入库单编号	,
FInstockTime	 as 	入库时间	,
Fstocker	 as 	仓管员
FROM  rds_dms_src_t_prd_instock
where CAST(FInstockTime  AS date)  = '",fdate,"' ")

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
#' Tmdms_productWarehousing_selectBydateRange()
Tmdms_productWarehousing_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("SELECT
FID	 as 	主键ID	,
FSubID	 as 	表体ID	,
FBilltypeName	 as 	单据类型名称	,
FBillNo	 as 	单据编号	,
Fseq	 as 	订单行号	,
FheadLot	 as 	订单表头批号	,
FDocumentStatus	 as 	单据状态	,
FBillTypeID	 as 	单据类型编码	,
Fdate	 as 	单据日期	,
FBillNoSource	 as 	订单单据编号	,
FMaterialCode	 as 	物料编码	,
Flot_entry	 as 	订单分录批号	,
ForderQty	 as 	订单数量	,
Fstatus_entry	 as 	订单状态	,
FCreateDate_entry	 as 	订单日期	,
FWorkShopName	 as 	生产车间	,
FcustomerCode	 as 	客户编号	,
FCustomerName	 as 	客户名称	,
FEntryID	 as 	订单分录ID	,
FMaterialName	 as 	订单物料名称	,
Fspecification	 as 	订单规格型号	,
FUnitName	 as 	订单单位名称	,
F_rds_ClassesCode	 as 	班次编码	,
F_rds_ClassesName	 as 	班次	,
FRealInstockQyt	 as 	实际入库数量	,
FConfirmInstockQty	 as 	待确认入库数量	,
FMaterialCode_instore	 as 	入库物料编码	,
FMaterialName_instore	 as 	入库物料名称	,
FMaterialUnit_instore	 as 	入库物料单位	,
Flot_instore	 as 	入库批号	,
Fqty_EntryQty	 as 	入库数量	,
FStockID	 as 	入库仓库代号	,
FInstockBillNo	 as 	入库单编号	,
FInstockTime	 as 	入库时间	,
Fstocker	 as 	仓管员
FROM  rds_dms_src_t_prd_instock
where CAST(FInstockTime  AS date) > ='",FStartDate,"' and CAST(FInstockTime  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




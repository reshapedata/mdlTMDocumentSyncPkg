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
#' TmWMS_prd_pickmtr_sekectBymonth()
TmWMS_prd_pickmtr_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("SELECT
a.id ,
b.sub_id ,
'生产领料_倒冲领料'  as billtype ,
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
END AS f_document_status,
a.f_bill_type ,
a.f_date ,
b.material_code   ,
b.batch_number  as  batch_number_entry ,
b.num as order_num ,
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
c.create_user_name ,
d.f_replace_group ,
d.f_material_number ,
d.f_material_name as f_sub_material_name,
d.f_material_model ,
d.f_material_type ,
d.f_numerator ,
d.f_denominator ,
d.f_unit_id_name ,
d.f_scrap_rate ,
d.f_std_qty ,
d.f_need_qty ,
d.f_must_qty ,
d.f_picked_qty ,
d.f_no_picked_qty ,
d.f_inventory_qty ,
d.f_is_skip ,
d.f_rds_water_check_box ,
d.f_act_picked_qty ,
CASE   WHEN d.STATUS IN ('2', '4') THEN '已出库'   ELSE '执行中'  END AS F_status ,
d.create_time as create_time_picked ,
d.f_entry_id as f_entry_id_stock ,
d.act_use_num ,
d.flot ,
d.erp_area_code

from view_product_instore_detail c
INNER JOIN view_product_order_detail b
on  c.order_detail_id = b.sub_id and c.order_id = b.product_order_id
INNER JOIN view_product_order   a
on  b.product_order_id = a.id
INNER JOIN view_product_act_use_material_detail d
on c.id =d.product_instore_order_detail_id
where YEAR(d.create_time) = '",fyear,"'
AND MONTH(d.create_time )='",fmonth,"'
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
#' TmWMS_prd_pickmtr_deleteBymonth()
TmWMS_prd_pickmtr_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_prd_pickmtrl_inverted
where YEAR(FPickedTime) = '",fyear,"' AND MONTH(FPickedTime )='",fmonth,"' ")

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
#' Tmdms_prd_pickmtr_selectByfbillno()
Tmdms_prd_pickmtr_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("SELECT
FID	as	主键ID	,
FSubID	as	表体ID	,
FBilltypeName	as	单据类型名称	,
FBillNo	as	单据编号	,
Fseq	as	订单行号	,
FheadLot	as	订单表头批号	,
FDocumentStatus	as	单据状态	,
FBillTypeID	as	单据类型编码	,
Fdate	as	单据日期	,
FMaterialCode	as	物料编码	,
Flot_entry	as	订单分录批号	,
ForderQty	as	订单数量	,
FCreateDate_entry	as	订单日期	,
FWorkShopName	as	生产车间	,
FcustomerCode	as	客户编号	,
FCustomerName	as	客户名称	,
FEntryID	as	订单分录ID	,
FMaterialName	as	订单物料名称	,
Fspecification	as	订单规格型号	,
FUnitName	as	订单单位名称	,
F_rds_ClassesCode	as	班次编码	,
F_rds_ClassesName	as	班次	,
FRealInstockQyt	as	实际入库数量	,
FConfirmInstockQty	as	待确认入库数量	,
FMaterialCode_instore	as	入库物料编码	,
FMaterialName_instore	as	入库物料名称	,
FMaterialUnit_instore	as	入库物料单位	,
Flot_instore	as	入库批号	,
Fqty_EntryQty	as	入库数量	,
FStockID	as	入库仓库代号	,
FInstockBillNo	as	入库单编号	,
FInstockTime	as	入库时间	,
Fstocker	as	仓管员	,
FSubEntryID	as	子项行号	,
FSubMaterialNumber	as	子项物料编码	,
FsubMaterialName	as	子项物料名称	,
FSubMaterialModel	as	子项型号规格	,
FSubMaterialType	as	子项物料类型	,
Fnumerator	as	分子	,
Fdenominator	as	分母	,
FSubUintName	as	子项单位	,
FScrapRate	as	变动损耗率	,
FSTDQty	as	标准数量	,
FNeedQty	as	需求数量	,
FMustQty	as	应发数量	,
FPickedQty	as	已领数量	,
FNoPickedQty	as	未领数量	,
FInventoryQty	as	可用库存	,
FIsSkip	as	跳层	,
F_RDS_Water	as	是否水口	,
FRealPickedQty	as	实领数量	,
Fstatsu_Picked	as	领料状态	,
FPickedTime	as	领料时间	,
FEntryID_Picked	as	领料分录ID	,
FActUseQty	as	领料实际倒扣数量	,
Flot_Picked	as	领料批号	,
FStockID_Picked	as	领料仓库编码
FROM rds_dms_src_t_prd_pickmtrl_inverted
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
#' Tmdms_prd_pickmtr_selectBydate()
Tmdms_prd_pickmtr_selectBydate<- function(dms_token,fdate) {
  sql=paste0("SELECT
FID	as	主键ID	,
FSubID	as	表体ID	,
FBilltypeName	as	单据类型名称	,
FBillNo	as	单据编号	,
Fseq	as	订单行号	,
FheadLot	as	订单表头批号	,
FDocumentStatus	as	单据状态	,
FBillTypeID	as	单据类型编码	,
Fdate	as	单据日期	,
FMaterialCode	as	物料编码	,
Flot_entry	as	订单分录批号	,
ForderQty	as	订单数量	,
FCreateDate_entry	as	订单日期	,
FWorkShopName	as	生产车间	,
FcustomerCode	as	客户编号	,
FCustomerName	as	客户名称	,
FEntryID	as	订单分录ID	,
FMaterialName	as	订单物料名称	,
Fspecification	as	订单规格型号	,
FUnitName	as	订单单位名称	,
F_rds_ClassesCode	as	班次编码	,
F_rds_ClassesName	as	班次	,
FRealInstockQyt	as	实际入库数量	,
FConfirmInstockQty	as	待确认入库数量	,
FMaterialCode_instore	as	入库物料编码	,
FMaterialName_instore	as	入库物料名称	,
FMaterialUnit_instore	as	入库物料单位	,
Flot_instore	as	入库批号	,
Fqty_EntryQty	as	入库数量	,
FStockID	as	入库仓库代号	,
FInstockBillNo	as	入库单编号	,
FInstockTime	as	入库时间	,
Fstocker	as	仓管员	,
FSubEntryID	as	子项行号	,
FSubMaterialNumber	as	子项物料编码	,
FsubMaterialName	as	子项物料名称	,
FSubMaterialModel	as	子项型号规格	,
FSubMaterialType	as	子项物料类型	,
Fnumerator	as	分子	,
Fdenominator	as	分母	,
FSubUintName	as	子项单位	,
FScrapRate	as	变动损耗率	,
FSTDQty	as	标准数量	,
FNeedQty	as	需求数量	,
FMustQty	as	应发数量	,
FPickedQty	as	已领数量	,
FNoPickedQty	as	未领数量	,
FInventoryQty	as	可用库存	,
FIsSkip	as	跳层	,
F_RDS_Water	as	是否水口	,
FRealPickedQty	as	实领数量	,
Fstatsu_Picked	as	领料状态	,
FPickedTime	as	领料时间	,
FEntryID_Picked	as	领料分录ID	,
FActUseQty	as	领料实际倒扣数量	,
Flot_Picked	as	领料批号	,
FStockID_Picked	as	领料仓库编码
FROM rds_dms_src_t_prd_pickmtrl_inverted
where CAST(FPickedTime  AS date)  = '",fdate,"' ")

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
#' Tmdms_prd_pickmtr_selectBydateRange()
Tmdms_prd_pickmtr_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("SELECT
FID	as	主键ID	,
FSubID	as	表体ID	,
FBilltypeName	as	单据类型名称	,
FBillNo	as	单据编号	,
Fseq	as	订单行号	,
FheadLot	as	订单表头批号	,
FDocumentStatus	as	单据状态	,
FBillTypeID	as	单据类型编码	,
Fdate	as	单据日期	,
FMaterialCode	as	物料编码	,
Flot_entry	as	订单分录批号	,
ForderQty	as	订单数量	,
FCreateDate_entry	as	订单日期	,
FWorkShopName	as	生产车间	,
FcustomerCode	as	客户编号	,
FCustomerName	as	客户名称	,
FEntryID	as	订单分录ID	,
FMaterialName	as	订单物料名称	,
Fspecification	as	订单规格型号	,
FUnitName	as	订单单位名称	,
F_rds_ClassesCode	as	班次编码	,
F_rds_ClassesName	as	班次	,
FRealInstockQyt	as	实际入库数量	,
FConfirmInstockQty	as	待确认入库数量	,
FMaterialCode_instore	as	入库物料编码	,
FMaterialName_instore	as	入库物料名称	,
FMaterialUnit_instore	as	入库物料单位	,
Flot_instore	as	入库批号	,
Fqty_EntryQty	as	入库数量	,
FStockID	as	入库仓库代号	,
FInstockBillNo	as	入库单编号	,
FInstockTime	as	入库时间	,
Fstocker	as	仓管员	,
FSubEntryID	as	子项行号	,
FSubMaterialNumber	as	子项物料编码	,
FsubMaterialName	as	子项物料名称	,
FSubMaterialModel	as	子项型号规格	,
FSubMaterialType	as	子项物料类型	,
Fnumerator	as	分子	,
Fdenominator	as	分母	,
FSubUintName	as	子项单位	,
FScrapRate	as	变动损耗率	,
FSTDQty	as	标准数量	,
FNeedQty	as	需求数量	,
FMustQty	as	应发数量	,
FPickedQty	as	已领数量	,
FNoPickedQty	as	未领数量	,
FInventoryQty	as	可用库存	,
FIsSkip	as	跳层	,
F_RDS_Water	as	是否水口	,
FRealPickedQty	as	实领数量	,
Fstatsu_Picked	as	领料状态	,
FPickedTime	as	领料时间	,
FEntryID_Picked	as	领料分录ID	,
FActUseQty	as	领料实际倒扣数量	,
Flot_Picked	as	领料批号	,
FStockID_Picked	as	领料仓库编码
FROM rds_dms_src_t_prd_pickmtrl_inverted
where CAST(FPickedTime  AS date) > ='",FStartDate,"' and CAST(FPickedTime  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




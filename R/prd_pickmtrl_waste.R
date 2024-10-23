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
#' TmWMS_prd_pickmtrl_waste_sekectBymonth()
TmWMS_prd_pickmtrl_waste_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
a.id ,
b.sub_id ,
'生产领料_废料入库'  as billtype ,
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
b.f_entry_id  as f_entry_id_entry,
b.f_material_name ,
b.f_specification ,
b.f_unit_name ,
b.act_instore_num ,
e.material_id ,
e.material_code ,
e.material_name ,
e.material_type_id ,
e.material_unit ,
e.raw_material_id ,
e.raw_material_code ,
e.raw_material_name ,
e.raw_material_type_id ,
e.raw_material_unit ,
e.out_num ,
e.out_batch_number ,
e.in_num ,
e.in_batch_number ,
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
END AS Ftype,
CASE
		WHEN e.current_process  = 'zz' THEN '组装线边库'
		WHEN e.current_process  = 'bm' THEN '宝马组装线边库'
		WHEN e.current_process  = 'GP12' THEN 'GP12线边库'
		WHEN e.current_process  = 'zd' THEN '蒸镀线边库'
		WHEN e.current_process  = 'uv' THEN 'uv线边库'
		WHEN e.current_process  = 'zs' THEN '注塑线边库'
END AS current_process,
CASE
		WHEN e.product_process  = 'zz' THEN '组装线边库'
		WHEN e.product_process  = 'bm' THEN '宝马组装线边库'
		WHEN e.product_process  = 'GP12' THEN 'GP12线边库'
		WHEN e.product_process  = 'zd' THEN '蒸镀线边库'
		WHEN e.product_process  = 'uv' THEN 'uv线边库'
		WHEN e.product_process  = 'zs' THEN '注塑线边库'
END AS product_process,
'02.02.01.01' as current_f_storck_id ,
e.waste_f_storck_id ,

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
where e.type  in (1,2,4,5,8,9)
AND  YEAR(f.create_time) = '",fyear,"'
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
#' TmWMS_prd_pickmtrl_waste_deleteBymonth()
TmWMS_prd_pickmtrl_waste_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_prd_pickmtrl_waste
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
#' Tmdms_prd_pickmtrl_waste_selectByfbillno()
Tmdms_prd_pickmtrl_waste_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select FID	as	主键ID	,
FSubID	as	表体ID	,
FBilltypeName	as	单据类型	,
FBillNo	as	单据编号	,
Fseq	as	订单行号	,
FheadLot	as	订单表头批号	,
FBillTypeID	as	单据类型编码	,
FDate	as	单据日期	,
FMaterialCode	as	物料编码	,
Flot_entry	as	订单分录批号	,
ForderQty	as	订单数量	,
FWorkShopName	as	生产车间	,
FcustomerCode	as	客户编号	,
FCustomerName	as	客户名称	,
FEntryID	as	订单分录ID	,
FMaterialName	as	订单物料名称	,
Fspecification	as	订单规格型号	,
FUnitName	as	订单单位名称	,
FRealInstockQyt	as	实际入库数量	,
FMaterialID_order	as	扣减_订单物料id	,
FmaterialCode_order	as	扣减_订单物料编号	,
FMaterialName_order	as	扣减_订单物料名称	,
FMaterial_TypeID_order	as	扣减_订单物料类型id	,
FMaterialUnit_order	as	扣减_订单物料单位	,
FMaterialID_picked	as	领料物料id	,
FMaterialCode_picked	as	领料物料编号	,
FMaterialName_picked	as	领料物料名称	,
FMaterialTypeID_picked	as	领料物料类型id	,
FMaterialUnit_picked	as	领料物料单位	,
FOutQty	as	扣减_物料重量	,
Flot_waste	as	扣减_物料批次	,
FProwasterQty	as	粉碎前_入库数量	,
FProwasterLot	as	粉碎前_入库批次	,
Ftype_waste	as	废料业务类型	,
FCurrentProcess	as	当前工序	,
FProductProcess	as	责任工序	,
FFStorckID_waste	as	ERP仓库编号	,
FProwasteStockID	as	粉碎前_入库仓库	,
Funit_scan	as	不良品单位	,
FProcessNGQty	as	本工序生产不良品数量	,
Flot_scan	as	不良品_批次号	,
Fcreator_scan	as	领料人	,
FcreateTime_scan	as	领料时间
from rds_dms_src_t_prd_pickmtrl_waste
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
#' Tmdms_prd_pickmtrl_waste_selectBydate()
Tmdms_prd_pickmtrl_waste_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select FID	as	主键ID	,
FSubID	as	表体ID	,
FBilltypeName	as	单据类型	,
FBillNo	as	单据编号	,
Fseq	as	订单行号	,
FheadLot	as	订单表头批号	,
FBillTypeID	as	单据类型编码	,
FDate	as	单据日期	,
FMaterialCode	as	物料编码	,
Flot_entry	as	订单分录批号	,
ForderQty	as	订单数量	,
FWorkShopName	as	生产车间	,
FcustomerCode	as	客户编号	,
FCustomerName	as	客户名称	,
FEntryID	as	订单分录ID	,
FMaterialName	as	订单物料名称	,
Fspecification	as	订单规格型号	,
FUnitName	as	订单单位名称	,
FRealInstockQyt	as	实际入库数量	,
FMaterialID_order	as	扣减_订单物料id	,
FmaterialCode_order	as	扣减_订单物料编号	,
FMaterialName_order	as	扣减_订单物料名称	,
FMaterial_TypeID_order	as	扣减_订单物料类型id	,
FMaterialUnit_order	as	扣减_订单物料单位	,
FMaterialID_picked	as	领料物料id	,
FMaterialCode_picked	as	领料物料编号	,
FMaterialName_picked	as	领料物料名称	,
FMaterialTypeID_picked	as	领料物料类型id	,
FMaterialUnit_picked	as	领料物料单位	,
FOutQty	as	扣减_物料重量	,
Flot_waste	as	扣减_物料批次	,
FProwasterQty	as	粉碎前_入库数量	,
FProwasterLot	as	粉碎前_入库批次	,
Ftype_waste	as	废料业务类型	,
FCurrentProcess	as	当前工序	,
FProductProcess	as	责任工序	,
FFStorckID_waste	as	ERP仓库编号	,
FProwasteStockID	as	粉碎前_入库仓库	,
Funit_scan	as	不良品单位	,
FProcessNGQty	as	本工序生产不良品数量	,
Flot_scan	as	不良品_批次号	,
Fcreator_scan	as	领料人	,
FcreateTime_scan	as	领料时间
from rds_dms_src_t_prd_pickmtrl_waste
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
#' Tmdms_prd_pickmtrl_waste_selectBydateRange()
Tmdms_prd_pickmtrl_waste_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select FID	as	主键ID	,
FSubID	as	表体ID	,
FBilltypeName	as	单据类型	,
FBillNo	as	单据编号	,
Fseq	as	订单行号	,
FheadLot	as	订单表头批号	,
FBillTypeID	as	单据类型编码	,
FDate	as	单据日期	,
FMaterialCode	as	物料编码	,
Flot_entry	as	订单分录批号	,
ForderQty	as	订单数量	,
FWorkShopName	as	生产车间	,
FcustomerCode	as	客户编号	,
FCustomerName	as	客户名称	,
FEntryID	as	订单分录ID	,
FMaterialName	as	订单物料名称	,
Fspecification	as	订单规格型号	,
FUnitName	as	订单单位名称	,
FRealInstockQyt	as	实际入库数量	,
FMaterialID_order	as	扣减_订单物料id	,
FmaterialCode_order	as	扣减_订单物料编号	,
FMaterialName_order	as	扣减_订单物料名称	,
FMaterial_TypeID_order	as	扣减_订单物料类型id	,
FMaterialUnit_order	as	扣减_订单物料单位	,
FMaterialID_picked	as	领料物料id	,
FMaterialCode_picked	as	领料物料编号	,
FMaterialName_picked	as	领料物料名称	,
FMaterialTypeID_picked	as	领料物料类型id	,
FMaterialUnit_picked	as	领料物料单位	,
FOutQty	as	扣减_物料重量	,
Flot_waste	as	扣减_物料批次	,
FProwasterQty	as	粉碎前_入库数量	,
FProwasterLot	as	粉碎前_入库批次	,
Ftype_waste	as	废料业务类型	,
FCurrentProcess	as	当前工序	,
FProductProcess	as	责任工序	,
FFStorckID_waste	as	ERP仓库编号	,
FProwasteStockID	as	粉碎前_入库仓库	,
Funit_scan	as	不良品单位	,
FProcessNGQty	as	本工序生产不良品数量	,
Flot_scan	as	不良品_批次号	,
Fcreator_scan	as	领料人	,
FcreateTime_scan	as	领料时间
from rds_dms_src_t_prd_pickmtrl_waste
where CAST(FcreateTime_scan  AS date) > ='",FStartDate,"' and CAST(FcreateTime_scan  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




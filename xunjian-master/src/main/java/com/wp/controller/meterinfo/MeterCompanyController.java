package com.wp.controller.meterinfo;

import com.wp.controller.base.BaseController;
import com.wp.entity.Page;
import com.wp.service.meterinfo.MeterCompanyService;
import com.wp.util.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value ="/meter_com")
public class MeterCompanyController extends BaseController {

    String menuUrl = "meter_com/list.do"; //菜单地址(权限用)
    @Resource(name="meterCompanyService")
    private MeterCompanyService meterCompanyService;

    /**
     *
     * @param page  输入查询关键字，没有查询关键字默认返回所有信息
     * @return
     */
    @RequestMapping(value="/list")
    public ModelAndView getMeterCompanyList(Page page) {
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
        logBefore(logger,"水表管理");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            String  enquiry = pd.getString("enquiry");
            if(null != enquiry && !"".equals(enquiry)){
                pd.put("enquiry", enquiry.trim());
            }else {
                pd.put("enquiry", "");
            }
            pd.put("factory_id",FactoryUtil.getFactoryId());
            page.setPd(pd);
            System.out.println(pd+"99999999999999999999");
            List<PageData> varList = meterCompanyService.list(page);
            mv.setViewName("meterinfo/metercompany");
            mv.addObject("varList", varList);
            mv.addObject("pd", pd);
            mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     *  删除水表公司
     * @param page 水表公司的id
     */
    @RequestMapping(value="/delete")
    public void goDelete(PageData page){
        logBefore(logger, "删除工厂");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try{
            pd=this.getPageData();
            meterCompanyService.delete(pd);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     *  去新增水表公司页面
     * @return
     */
    @RequestMapping(value="/goAdd")
    public ModelAndView goAdd( ){
        logBefore(logger, "去新增水表工厂页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            mv.setViewName("meterinfo/metercom_edit");
            mv.addObject("msg", "save");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     *   保存结果
     * @param out
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/save")
    public ModelAndView save(PrintWriter out) throws Exception{
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("checktime",  Tools.date2Str(new Date()));	//添加时间
        pd.put("factory_id",FactoryUtil.getFactoryId());
        meterCompanyService.save(pd);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     *  去修改水表信息页面
     * @return
     */
    @RequestMapping(value="/goEdit")
    public ModelAndView goEdit(){
        logBefore(logger, "去修改水表工厂页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            pd = meterCompanyService.findById(pd);	//根据ID读取
            mv.setViewName("meterinfo/metercom_edit");
            mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     *  修改信息
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/edit")
    public ModelAndView edit() throws Exception {
        logBefore(logger, "修改水表公司信息");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;}
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd=this.getPageData();
        meterCompanyService.edit(pd);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;
    }
    /* ===============================权限================================== */
    public Map<String, String> getHC(){
        Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */


}
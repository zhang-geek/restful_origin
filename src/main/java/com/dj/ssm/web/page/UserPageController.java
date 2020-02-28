package com.dj.ssm.web.page;

import com.dj.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author zhangzk
 * @description TODO
 * @date 2020/2/23 20:19
 */
@RequestMapping("user")
@Controller
public class UserPageController {

    @Autowired
    private UserService userService;

    @RequestMapping("toCreate")
    public String toCreate() {
        return "user/create";
    }
    @RequestMapping("toUpdate")
    public String toUpdate(Integer id, Model model) {
        model.addAttribute("user",userService.getById(id));
        return "user/update";
    }
    @RequestMapping("toShow")
    public String toShow() {
        return "user/show";
    }
}

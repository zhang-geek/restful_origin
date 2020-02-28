package com.dj.ssm.web;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dj.ssm.common.ResultModel;
import com.dj.ssm.common.SystemConstant;
import com.dj.ssm.pojo.User;
import com.dj.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zhangzk
 * @description TODO
 * @date 2020/2/22 19:31
 */
@RestController
@RequestMapping("users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/{id}")
    public ResultModel<Object> get(@PathVariable Integer id) {
        try {
            User user = userService.getById(id);
            return new ResultModel<>().success(user);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }

    @PostMapping
    public ResultModel<Object> create(User user) {
        try {
            user.setCreateTime(new Date()).setIsDel(1);
            userService.save(user);
            return new ResultModel<>().success();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }

    @PutMapping
    public ResultModel update( User user) {
        try {
            userService.updateById(user);
            return new ResultModel().success();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }

    @DeleteMapping
    public ResultModel delete(User user) {
        try {
            userService.updateById(user);
            return new ResultModel().success();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }

    @PostMapping("list")
    public ResultModel list(Integer pageNo, Integer pageSize, User user) {
        try {
            Map<String, Object> resultMap = new HashMap<>();
            Page<User> page = new Page(pageNo, pageSize);
            QueryWrapper<User> queryWrapper = new QueryWrapper<User>();
            if (!StringUtils.isEmpty(user.getUsername())) {
                queryWrapper.like("username", user.getUsername());
            }
            if (user.getSex() != null && user.getSex() != 0) {
                queryWrapper.eq("sex", user.getSex());
            }
            if (user.getStartAge() != null) {
                queryWrapper.gt("age", user.getStartAge());
            }
            if (user.getEndAge() != null) {
                queryWrapper.lt("age", user.getEndAge());
            }
            queryWrapper.eq("is_del", SystemConstant.IS_DEL_1);
            queryWrapper.orderByDesc("id");
            Page<User> userPage = userService.page(page, queryWrapper);
            resultMap.put("list", userPage.getRecords());
            resultMap.put("totalNum", userPage.getPages());
            return new ResultModel().success(resultMap);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }

    @GetMapping("deDuplicate")
    public Boolean deDuplicate(String username) {
        return userService.getOne(new QueryWrapper<User>().eq("username", username)) == null;
    }

}

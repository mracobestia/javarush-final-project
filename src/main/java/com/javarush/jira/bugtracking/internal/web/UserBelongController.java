package com.javarush.jira.bugtracking.internal.web;

import com.javarush.jira.bugtracking.to.UserBelongTo;
import com.javarush.jira.bugtracking.UserBelongService;
import com.javarush.jira.login.AuthUser;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import static org.springframework.http.HttpStatus.CREATED;

@RestController
@RequestMapping(value = UserBelongController.REST_URL, produces = MediaType.APPLICATION_JSON_VALUE)
@AllArgsConstructor
@Slf4j
public class UserBelongController {

    static final String REST_URL = "/api/bugtracking/subscription";
    private UserBelongService userBelongService;

    @PostMapping
    @Transactional
    @ResponseStatus(CREATED)
    public void create(@RequestBody UserBelongTo userBelongTo,
                                             @AuthenticationPrincipal AuthUser authUser) {

        userBelongService.create(userBelongTo, authUser);
    }
}

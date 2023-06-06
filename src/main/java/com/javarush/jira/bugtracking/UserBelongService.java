package com.javarush.jira.bugtracking;

import com.javarush.jira.bugtracking.internal.mapper.UserBelongMapper;
import com.javarush.jira.bugtracking.internal.model.Task;
import com.javarush.jira.bugtracking.internal.model.UserBelong;
import com.javarush.jira.bugtracking.internal.repository.TaskRepository;
import com.javarush.jira.bugtracking.internal.repository.UserBelongRepository;
import com.javarush.jira.bugtracking.to.UserBelongTo;
import com.javarush.jira.common.error.NotFoundException;
import com.javarush.jira.login.AuthUser;
import com.javarush.jira.login.Role;
import com.javarush.jira.ref.RefType;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@AllArgsConstructor
public class UserBelongService {

    private UserBelongRepository userBelongRepository;
    private UserBelongMapper mapper;

    public void create(UserBelongTo userBelongTo, AuthUser authUser) {
        String userType = authUser.isAdmin() ? "admin" : "user";
        long id = authUser.id();
        UserBelong userBelong = mapper.toEntity(userBelongTo, userType, id);
        userBelongRepository.saveAndFlush(userBelong);
    }

}

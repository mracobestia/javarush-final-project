package com.javarush.jira.bugtracking.internal.mapper;

import com.javarush.jira.bugtracking.internal.model.Activity;
import com.javarush.jira.bugtracking.internal.model.Task;
import com.javarush.jira.bugtracking.to.ActivityTo;
import com.javarush.jira.bugtracking.to.ProjectTo;
import com.javarush.jira.bugtracking.to.SprintTo;
import com.javarush.jira.bugtracking.to.TaskTo;
import com.javarush.jira.common.BaseMapper;
import com.javarush.jira.login.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;
import java.util.*;

@Mapper(componentModel = "spring", uses = {SprintMapper.class, ProjectMapper.class})
public interface TaskMapper extends BaseMapper<Task, TaskTo> {

    @Mapping(target = "enabled", expression = "java(task.isEnabled())")
    @Mapping(target = "activities", ignore = true)
    @Override
    TaskTo toTo(Task task);

    @Override
    Task toEntity(TaskTo taskTo);

    @Override
    List<TaskTo> toToList(Collection<Task> tasks);

}

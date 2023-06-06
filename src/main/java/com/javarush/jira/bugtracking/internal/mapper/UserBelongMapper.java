package com.javarush.jira.bugtracking.internal.mapper;

import com.javarush.jira.bugtracking.internal.model.UserBelong;
import com.javarush.jira.bugtracking.to.ObjectType;
import com.javarush.jira.bugtracking.to.UserBelongTo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;


import java.util.Collection;
import java.util.List;

@Mapper(componentModel = "spring", imports = {ObjectType.class})
public interface UserBelongMapper {

    UserBelongTo toTo(UserBelong userBelong);

    @Mapping(target = "userTypeCode", source = "role")
    @Mapping(target = "userId", source = "id")
    @Mapping(target = "objectType", expression = "java(ObjectType.valueOf(userBelongTo.getObjectType()))")
    UserBelong toEntity(UserBelongTo userBelongTo, String role, Long id);

    List<UserBelongTo> toToList(Collection<UserBelong> userBelongs);

}

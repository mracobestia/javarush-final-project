package com.javarush.jira.bugtracking.to;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class UserBelongTo {

    @NotNull(message = "objectId")
    Long objectId;

    @NotNull
    String objectType;

    @Nullable
    LocalDateTime startpoint;

    @Nullable
    LocalDateTime endpoint;

    public UserBelongTo(Long objectId, String objectType, LocalDateTime startpoint, LocalDateTime endpoint) {
        this.objectId = objectId;
        this.objectType = objectType;
        this.startpoint = startpoint;
        this.endpoint = endpoint;
    }
}

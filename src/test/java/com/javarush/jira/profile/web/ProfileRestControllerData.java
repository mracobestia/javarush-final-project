package com.javarush.jira.profile.web;

import com.javarush.jira.MatcherFactory;
import com.javarush.jira.profile.ProfileTo;
import com.javarush.jira.profile.internal.Profile;
import com.javarush.jira.ref.RefTo;
import com.javarush.jira.ref.RefType;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

public class ProfileRestControllerData {

    public static final MatcherFactory.Matcher<Profile> PROFILE_MATCHER = MatcherFactory.usingIgnoringFieldsComparator(Profile.class, "contacts");
    public static final MatcherFactory.Matcher<ProfileTo> PROFILETO_MATCHER = MatcherFactory.usingIgnoringFieldsComparator(ProfileTo.class, "contacts");

    public static final long USER_ID = 1;
    public static final String USER_MAIL = "user@gmail.com";

    public static Profile getNew() {
        Profile newProfile = new Profile(USER_ID);
        newProfile.setMailNotifications(49);
        return newProfile;
    }

    public static Profile getUpdated() {
        Profile profileToUpdate = new Profile(USER_ID);
        profileToUpdate.setMailNotifications(63);
        return profileToUpdate;
    }

}

# Используем базовый образ с Java 17 и сервером приложений Apache Tomcat
FROM tomcat:9

# Копируем WAR-файл внутрь контейнера
COPY target/jira-1.0.war /usr/local/tomcat/webapps/

# Устанавливаем переменные среды
ENV SPRING_PROFILES_ACTIVE=prod
ENV HOST_URL=http://localhost:8080
ENV TEST_MAIL=jira4jr@gmail.com
ENV POSTGRES_CONNECT=jdbc:postgresql://172.17.0.3:5432/jira
ENV POSTGRES_LOGIN=postgres
ENV POSTGRES_PASSWORD=postgres
ENV GITHUB_CLIENT_ID=3d0d8738e65881fff266
ENV GITHUB_CLIENT_SECRET=0f97031ce6178b7dfb67a6af587f37e222a16120
ENV GOOGLE_CLIENT_ID=329113642700-f8if6pu68j2repq3ef6umd5jgiliup60.apps.googleusercontent.com
ENV GOOGLE_CLIENT_SECRET=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
ENV GITLAB_CLIENT_ID=b8520a3266089063c0d8261cce36971defa513f5ffd9f9b7a3d16728fc83a494
ENV GITLAB_CLIENT_SECRET=e72c65320cf9d6495984a37b0f9cc03ec46be0bb6f071feaebbfe75168117004
ENV MAIL_HOST=smtp.gmail.com
ENV MAIL_USERNAME=jira4jr@gmail.com
ENV MAIL_PASSWORD=zdfzsrqvgimldzyj

# Открываем порт, на котором будет работать приложение
EXPOSE 8080

# Запускаем приложение при запуске контейнера
CMD ["catalina.sh", "run"]

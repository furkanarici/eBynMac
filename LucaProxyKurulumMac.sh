#!/bin/bash
mkdir -p ~/LucaProxy/
mkdir -p ~/LucaProxy/tmp/
mkdir -p ~/LucaProxy/lib
curl -L "https://auygs.luca.com.tr/Luca/yardim/uygulamalar/LucaProxy.jar" -o ~/LucaProxy/LucaProxy.jar
curl -L "https://auygs.luca.com.tr/Luca/yardim/uygulamalar/turkkep-esign-client-1.0.0.jar" -o ~/LucaProxy/lib/turkkep-esign-client-1.0.0.jar
curl -L "https://auygs.luca.com.tr/Luca/yardim/uygulamalar/agem-updater-1.0.0.jar" -o ~/LucaProxy/lib/agem-updater-1.0.0.jar
curl -L "https://auygs.luca.com.tr/Luca/yardim/uygulamalar/selenium-util-1.0.0.jar" -o ~/LucaProxy/lib/selenium-util-1.0.0.jar

curl -L "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.14%2B9/OpenJDK11U-jre_x64_mac_hotspot_11.0.14_9.tar.gz" -o ~/LucaProxy/tmp/openjre.11.0.14_9.tar.gz

curl -L "https://repo.maven.apache.org/maven2/javax/activation/activation/1.1/activation-1.1.jar" -o ~/LucaProxy/lib/activation-1.1.jar
curl -L "https://repo.maven.apache.org/maven2/org/jetbrains/annotations/13.0/annotations-13.0.jar" -o ~/LucaProxy/lib/annotations-13.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/asynchttpclient/async-http-client/2.12.3/async-http-client-2.12.3.jar" -o ~/LucaProxy/lib/async-http-client-2.12.3.jar
curl -L "https://repo.maven.apache.org/maven2/org/asynchttpclient/async-http-client-netty-utils/2.12.3/async-http-client-netty-utils-2.12.3.jar" -o ~/LucaProxy/lib/async-http-client-netty-utils-2.12.3.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/auto/auto-common/1.2/auto-common-1.2.jar" -o ~/LucaProxy/lib/auto-common-1.2.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/auto/service/auto-service/1.0.1/auto-service-1.0.1.jar" -o ~/LucaProxy/lib/auto-service-1.0.1.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/auto/service/auto-service-annotations/1.0.1/auto-service-annotations-1.0.1.jar" -o ~/LucaProxy/lib/auto-service-annotations-1.0.1.jar
curl -L "https://repo.maven.apache.org/maven2/org/bouncycastle/bcpkix-jdk15on/1.64/bcpkix-jdk15on-1.64.jar" -o ~/LucaProxy/lib/bcpkix-jdk15on-1.64.jar
curl -L "https://repo.maven.apache.org/maven2/org/bouncycastle/bcprov-jdk15on/1.64/bcprov-jdk15on-1.64.jar" -o ~/LucaProxy/lib/bcprov-jdk15on-1.64.jar
curl -L "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy/1.12.18/byte-buddy-1.12.18.jar" -o ~/LucaProxy/lib/byte-buddy-1.12.18.jar
curl -L "https://repo.maven.apache.org/maven2/org/checkerframework/checker-qual/3.12.0/checker-qual-3.12.0.jar" -o ~/LucaProxy/lib/checker-qual-3.12.0.jar
curl -L "https://repo.maven.apache.org/maven2/commons-beanutils/commons-beanutils/1.9.3/commons-beanutils-1.9.3.jar" -o ~/LucaProxy/lib/commons-beanutils-1.9.3.jar
curl -L "https://repo.maven.apache.org/maven2/commons-codec/commons-codec/1.9/commons-codec-1.9.jar" -o ~/LucaProxy/lib/commons-codec-1.9.jar
curl -L "https://repo.maven.apache.org/maven2/commons-collections/commons-collections/3.2.2/commons-collections-3.2.2.jar" -o ~/LucaProxy/lib/commons-collections-3.2.2.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/commons/commons-compress/1.22/commons-compress-1.22.jar" -o ~/LucaProxy/lib/commons-compress-1.22.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/commons/commons-exec/1.3/commons-exec-1.3.jar" -o ~/LucaProxy/lib/commons-exec-1.3.jar
curl -L "https://repo.maven.apache.org/maven2/commons-fileupload/commons-fileupload/1.4/commons-fileupload-1.4.jar" -o ~/LucaProxy/lib/commons-fileupload-1.4.jar
curl -L "https://repo.maven.apache.org/maven2/commons-httpclient/commons-httpclient/3.1/commons-httpclient-3.1.jar" -o ~/LucaProxy/lib/commons-httpclient-3.1.jar
curl -L "https://repo.maven.apache.org/maven2/commons-io/commons-io/2.6/commons-io-2.6.jar" -o ~/LucaProxy/lib/commons-io-2.6.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar" -o ~/LucaProxy/lib/commons-lang3-3.12.0.jar
curl -L "https://repo.maven.apache.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.jar" -o ~/LucaProxy/lib/commons-logging-1.2.jar
curl -L "https://repo.maven.apache.org/maven2/org/brotli/dec/0.1.2/dec-0.1.2.jar" -o ~/LucaProxy/lib/dec-0.1.2.jar
curl -L "https://repo.maven.apache.org/maven2/com/github/docker-java/docker-java/3.2.13/docker-java-3.2.13.jar" -o ~/LucaProxy/lib/docker-java-3.2.13.jar
curl -L "https://repo.maven.apache.org/maven2/com/github/docker-java/docker-java-api/3.2.13/docker-java-api-3.2.13.jar" -o ~/LucaProxy/lib/docker-java-api-3.2.13.jar
curl -L "https://repo.maven.apache.org/maven2/com/github/docker-java/docker-java-core/3.2.13/docker-java-core-3.2.13.jar" -o ~/LucaProxy/lib/docker-java-core-3.2.13.jar
curl -L "https://repo.maven.apache.org/maven2/com/github/docker-java/docker-java-transport/3.2.13/docker-java-transport-3.2.13.jar" -o ~/LucaProxy/lib/docker-java-transport-3.2.13.jar
curl -L "https://repo.maven.apache.org/maven2/com/github/docker-java/docker-java-transport-httpclient5/3.2.13/docker-java-transport-httpclient5-3.2.13.jar" -o ~/LucaProxy/lib/docker-java-transport-httpclient5-3.2.13.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.11.0/error_prone_annotations-2.11.0.jar" -o ~/LucaProxy/lib/error_prone_annotations-2.11.0.jar
curl -L "https://repo.maven.apache.org/maven2/dev/failsafe/failsafe/3.3.0/failsafe-3.3.0.jar" -o ~/LucaProxy/lib/failsafe-3.3.0.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar" -o ~/LucaProxy/lib/failureaccess-1.0.1.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/pdfbox/fontbox/2.0.25/fontbox-2.0.25.jar" -o ~/LucaProxy/lib/fontbox-2.0.25.jar
curl -L "https://repo.maven.apache.org/maven2/org/ghost4j/ghost4j/1.0.1/ghost4j-1.0.1.jar" -o ~/LucaProxy/lib/ghost4j-1.0.1.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.10/gson-2.10.jar" -o ~/LucaProxy/lib/gson-2.10.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/guava/guava/31.1-jre/guava-31.1-jre.jar" -o ~/LucaProxy/lib/guava-31.1-jre.jar
curl -L "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar" -o ~/LucaProxy/lib/hamcrest-core-1.3.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/httpcomponents/httpclient/4.5.3/httpclient-4.5.3.jar" -o ~/LucaProxy/lib/httpclient-4.5.3.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/httpcomponents/client5/httpclient5/5.1.3/httpclient5-5.1.3.jar" -o ~/LucaProxy/lib/httpclient5-5.1.3.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/httpcomponents/httpcore/4.4.6/httpcore-4.4.6.jar" -o ~/LucaProxy/lib/httpcore-4.4.6.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/httpcomponents/core5/httpcore5/5.1.3/httpcore5-5.1.3.jar" -o ~/LucaProxy/lib/httpcore5-5.1.3.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/httpcomponents/core5/httpcore5-h2/5.1.3/httpcore5-h2-5.1.3.jar" -o ~/LucaProxy/lib/httpcore5-h2-5.1.3.jar
curl -L "https://repo.maven.apache.org/maven2/com/lowagie/itext/2.1.7/itext-2.1.7.jar" -o ~/LucaProxy/lib/itext-2.1.7.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar" -o ~/LucaProxy/lib/j2objc-annotations-1.3.jar
curl -L "https://repo.maven.apache.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.9.0/jackson-annotations-2.9.0.jar" -o ~/LucaProxy/lib/jackson-annotations-2.9.0.jar
curl -L "https://repo.maven.apache.org/maven2/com/fasterxml/jackson/core/jackson-core/2.9.2/jackson-core-2.9.2.jar" -o ~/LucaProxy/lib/jackson-core-2.9.2.jar
curl -L "https://repo.maven.apache.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.9.2/jackson-databind-2.9.2.jar" -o ~/LucaProxy/lib/jackson-databind-2.9.2.jar
curl -L "https://repo.maven.apache.org/maven2/com/github/jai-imageio/jai-imageio-core/1.4.0/jai-imageio-core-1.4.0.jar" -o ~/LucaProxy/lib/jai-imageio-core-1.4.0.jar
curl -L "https://repo.maven.apache.org/maven2/com/sun/activation/jakarta.activation/1.2.2/jakarta.activation-1.2.2.jar" -o ~/LucaProxy/lib/jakarta.activation-1.2.2.jar
curl -L "https://repo.maven.apache.org/maven2/com/sun/mail/javax.mail/1.6.2/javax.mail-1.6.2.jar" -o ~/LucaProxy/lib/javax.mail-1.6.2.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/pdfbox/jbig2-imageio/3.0.3/jbig2-imageio-3.0.3.jar" -o ~/LucaProxy/lib/jbig2-imageio-3.0.3.jar
curl -L "https://repo.maven.apache.org/maven2/org/jboss/logging/jboss-logging/3.1.4.GA/jboss-logging-3.1.4.GA.jar" -o ~/LucaProxy/lib/jboss-logging-3.1.4.GA.jar
curl -L "https://repo.maven.apache.org/maven2/org/jboss/jboss-vfs/3.2.16.Final/jboss-vfs-3.2.16.Final.jar" -o ~/LucaProxy/lib/jboss-vfs-3.2.16.Final.jar
curl -L "https://repo.maven.apache.org/maven2/org/slf4j/jcl-over-slf4j/1.7.30/jcl-over-slf4j-1.7.30.jar" -o ~/LucaProxy/lib/jcl-over-slf4j-1.7.30.jar
curl -L "https://repo.maven.apache.org/maven2/com/beust/jcommander/1.82/jcommander-1.82.jar" -o ~/LucaProxy/lib/jcommander-1.82.jar
curl -L "https://repo.maven.apache.org/maven2/net/java/dev/jna/jna/5.10.0/jna-5.10.0.jar" -o ~/LucaProxy/lib/jna-5.10.0.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar" -o ~/LucaProxy/lib/jsr305-3.0.2.jar
curl -L "https://repo.maven.apache.org/maven2/io/ous/jtoml/2.0.0/jtoml-2.0.0.jar" -o ~/LucaProxy/lib/jtoml-2.0.0.jar
curl -L "https://repo.maven.apache.org/maven2/junit/junit/4.12/junit-4.12.jar" -o ~/LucaProxy/lib/junit-4.12.jar
curl -L "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib/1.4.10/kotlin-stdlib-1.4.10.jar" -o ~/LucaProxy/lib/kotlin-stdlib-1.4.10.jar
curl -L "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-common/1.4.0/kotlin-stdlib-common-1.4.0.jar" -o ~/LucaProxy/lib/kotlin-stdlib-common-1.4.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-jdk7/1.4.10/kotlin-stdlib-jdk7-1.4.10.jar" -o ~/LucaProxy/lib/kotlin-stdlib-jdk7-1.4.10.jar
curl -L "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-jdk8/1.4.10/kotlin-stdlib-jdk8-1.4.10.jar" -o ~/LucaProxy/lib/kotlin-stdlib-jdk8-1.4.10.jar
curl -L "https://repo.maven.apache.org/maven2/net/sourceforge/lept4j/lept4j/1.16.1/lept4j-1.16.1.jar" -o ~/LucaProxy/lib/lept4j-1.16.1.jar
curl -L "https://repo.maven.apache.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar" -o ~/LucaProxy/lib/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar
curl -L "https://repo.maven.apache.org/maven2/log4j/log4j/1.2.17/log4j-1.2.17.jar" -o ~/LucaProxy/lib/log4j-1.2.17.jar
curl -L "https://repo.maven.apache.org/maven2/com/squareup/okhttp3/logging-interceptor/4.9.1/logging-interceptor-4.9.1.jar" -o ~/LucaProxy/lib/logging-interceptor-4.9.1.jar
curl -L "https://repo.maven.apache.org/maven2/com/miglayout/miglayout/3.7.4/miglayout-3.7.4.jar" -o ~/LucaProxy/lib/miglayout-3.7.4.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-buffer/4.1.84.Final/netty-buffer-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-buffer-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-codec/4.1.84.Final/netty-codec-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-codec-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-codec-http/4.1.84.Final/netty-codec-http-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-codec-http-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-codec-socks/4.1.60.Final/netty-codec-socks-4.1.60.Final.jar" -o ~/LucaProxy/lib/netty-codec-socks-4.1.60.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-common/4.1.84.Final/netty-common-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-common-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-handler/4.1.84.Final/netty-handler-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-handler-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-handler-proxy/4.1.60.Final/netty-handler-proxy-4.1.60.Final.jar" -o ~/LucaProxy/lib/netty-handler-proxy-4.1.60.Final.jar
curl -L "https://repo.maven.apache.org/maven2/com/typesafe/netty/netty-reactive-streams/2.0.4/netty-reactive-streams-2.0.4.jar" -o ~/LucaProxy/lib/netty-reactive-streams-2.0.4.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-resolver/4.1.84.Final/netty-resolver-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-resolver-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-transport/4.1.84.Final/netty-transport-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-transport-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-transport-classes-epoll/4.1.84.Final/netty-transport-classes-epoll-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-transport-classes-epoll-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-transport-classes-kqueue/4.1.84.Final/netty-transport-classes-kqueue-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-transport-classes-kqueue-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-transport-native-epoll/4.1.60.Final/netty-transport-native-epoll-4.1.60.Final-linux-x86_64.jar" -o ~/LucaProxy/lib/netty-transport-native-epoll-4.1.60.Final-linux-x86_64.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-transport-native-epoll/4.1.84.Final/netty-transport-native-epoll-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-transport-native-epoll-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-transport-native-kqueue/4.1.60.Final/netty-transport-native-kqueue-4.1.60.Final-osx-x86_64.jar" -o ~/LucaProxy/lib/netty-transport-native-kqueue-4.1.60.Final-osx-x86_64.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-transport-native-kqueue/4.1.84.Final/netty-transport-native-kqueue-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-transport-native-kqueue-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/io/netty/netty-transport-native-unix-common/4.1.84.Final/netty-transport-native-unix-common-4.1.84.Final.jar" -o ~/LucaProxy/lib/netty-transport-native-unix-common-4.1.84.Final.jar
curl -L "https://repo.maven.apache.org/maven2/com/squareup/okhttp3/okhttp/4.9.1/okhttp-4.9.1.jar" -o ~/LucaProxy/lib/okhttp-4.9.1.jar
curl -L "https://repo.maven.apache.org/maven2/com/squareup/okio/okio/2.8.0/okio-2.8.0.jar" -o ~/LucaProxy/lib/okio-2.8.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-api/1.19.0/opentelemetry-api-1.19.0.jar" -o ~/LucaProxy/lib/opentelemetry-api-1.19.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-api-logs/1.19.0-alpha/opentelemetry-api-logs-1.19.0-alpha.jar" -o ~/LucaProxy/lib/opentelemetry-api-logs-1.19.0-alpha.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-context/1.19.0/opentelemetry-context-1.19.0.jar" -o ~/LucaProxy/lib/opentelemetry-context-1.19.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-exporter-common/1.19.0/opentelemetry-exporter-common-1.19.0.jar" -o ~/LucaProxy/lib/opentelemetry-exporter-common-1.19.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-exporter-logging/1.19.0/opentelemetry-exporter-logging-1.19.0.jar" -o ~/LucaProxy/lib/opentelemetry-exporter-logging-1.19.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-sdk/1.19.0/opentelemetry-sdk-1.19.0.jar" -o ~/LucaProxy/lib/opentelemetry-sdk-1.19.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-sdk-common/1.19.0/opentelemetry-sdk-common-1.19.0.jar" -o ~/LucaProxy/lib/opentelemetry-sdk-common-1.19.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-sdk-extension-autoconfigure/1.19.0-alpha/opentelemetry-sdk-extension-autoconfigure-1.19.0-alpha.jar" -o ~/LucaProxy/lib/opentelemetry-sdk-extension-autoconfigure-1.19.0-alpha.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-sdk-extension-autoconfigure-spi/1.19.0/opentelemetry-sdk-extension-autoconfigure-spi-1.19.0.jar" -o ~/LucaProxy/lib/opentelemetry-sdk-extension-autoconfigure-spi-1.19.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-sdk-logs/1.19.0-alpha/opentelemetry-sdk-logs-1.19.0-alpha.jar" -o ~/LucaProxy/lib/opentelemetry-sdk-logs-1.19.0-alpha.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-sdk-metrics/1.19.0/opentelemetry-sdk-metrics-1.19.0.jar" -o ~/LucaProxy/lib/opentelemetry-sdk-metrics-1.19.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-sdk-trace/1.19.0/opentelemetry-sdk-trace-1.19.0.jar" -o ~/LucaProxy/lib/opentelemetry-sdk-trace-1.19.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/opentelemetry/opentelemetry-semconv/1.19.0-alpha/opentelemetry-semconv-1.19.0-alpha.jar" -o ~/LucaProxy/lib/opentelemetry-semconv-1.19.0-alpha.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/pdfbox/pdfbox/2.0.25/pdfbox-2.0.25.jar" -o ~/LucaProxy/lib/pdfbox-2.0.25.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/pdfbox/pdfbox-debugger/2.0.25/pdfbox-debugger-2.0.25.jar" -o ~/LucaProxy/lib/pdfbox-debugger-2.0.25.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/pdfbox/pdfbox-tools/2.0.25/pdfbox-tools-2.0.25.jar" -o ~/LucaProxy/lib/pdfbox-tools-2.0.25.jar
curl -L "https://repo.maven.apache.org/maven2/org/reactivestreams/reactive-streams/1.0.3/reactive-streams-1.0.3.jar" -o ~/LucaProxy/lib/reactive-streams-1.0.3.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-api/4.6.0/selenium-api-4.6.0.jar" -o ~/LucaProxy/lib/selenium-api-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-chrome-driver/4.6.0/selenium-chrome-driver-4.6.0.jar" -o ~/LucaProxy/lib/selenium-chrome-driver-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-chromium-driver/4.6.0/selenium-chromium-driver-4.6.0.jar" -o ~/LucaProxy/lib/selenium-chromium-driver-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-devtools-v105/4.6.0/selenium-devtools-v105-4.6.0.jar" -o ~/LucaProxy/lib/selenium-devtools-v105-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-devtools-v106/4.6.0/selenium-devtools-v106-4.6.0.jar" -o ~/LucaProxy/lib/selenium-devtools-v106-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-devtools-v107/4.6.0/selenium-devtools-v107-4.6.0.jar" -o ~/LucaProxy/lib/selenium-devtools-v107-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-devtools-v85/4.6.0/selenium-devtools-v85-4.6.0.jar" -o ~/LucaProxy/lib/selenium-devtools-v85-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-edge-driver/4.6.0/selenium-edge-driver-4.6.0.jar" -o ~/LucaProxy/lib/selenium-edge-driver-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-firefox-driver/4.6.0/selenium-firefox-driver-4.6.0.jar" -o ~/LucaProxy/lib/selenium-firefox-driver-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-http/4.6.0/selenium-http-4.6.0.jar" -o ~/LucaProxy/lib/selenium-http-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-ie-driver/4.6.0/selenium-ie-driver-4.6.0.jar" -o ~/LucaProxy/lib/selenium-ie-driver-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-java/4.6.0/selenium-java-4.6.0.jar" -o ~/LucaProxy/lib/selenium-java-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-json/4.6.0/selenium-json-4.6.0.jar" -o ~/LucaProxy/lib/selenium-json-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-manager/4.6.0/selenium-manager-4.6.0.jar" -o ~/LucaProxy/lib/selenium-manager-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-remote-driver/4.6.0/selenium-remote-driver-4.6.0.jar" -o ~/LucaProxy/lib/selenium-remote-driver-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-safari-driver/4.6.0/selenium-safari-driver-4.6.0.jar" -o ~/LucaProxy/lib/selenium-safari-driver-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/seleniumhq/selenium/selenium-support/4.6.0/selenium-support-4.6.0.jar" -o ~/LucaProxy/lib/selenium-support-4.6.0.jar
curl -L "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.32/slf4j-api-1.7.32.jar" -o ~/LucaProxy/lib/slf4j-api-1.7.32.jar
curl -L "https://repo.maven.apache.org/maven2/net/sourceforge/tess4j/tess4j/5.1.0/tess4j-5.1.0.jar" -o ~/LucaProxy/lib/tess4j-5.1.0.jar
curl -L "https://repo.maven.apache.org/maven2/io/github/bonigarcia/webdrivermanager/5.3.1/webdrivermanager-5.3.1.jar" -o ~/LucaProxy/lib/webdrivermanager-5.3.1.jar
curl -L "https://repo.maven.apache.org/maven2/org/apache/xmlgraphics/xmlgraphics-commons/1.4/xmlgraphics-commons-1.4.jar" -o ~/LucaProxy/lib/xmlgraphics-commons-1.4.jar

tar xzvf ~/LucaProxy/tmp/openjre.11.0.14_9.tar.gz --directory ~/LucaProxy/
unzip -oj ~/LucaProxy/lib/tess4j-5.1.0.jar 'tessdata/*' -d ~/LucaProxy/tessdata/
unzip -oj ~/LucaProxy/lib/tess4j-5.1.0.jar 'tessdata/configs/*' -d ~/LucaProxy/tessdata/configs/
echo '#!/bin/bash' > ~/LucaProxy/lucaproxy.sh
echo 'cd ~/LucaProxy/' >> ~/LucaProxy/lucaproxy.sh
echo '~/LucaProxy/jdk-11.0.14+9-jre/Contents/Home/bin/java -jar -Dfile.encoding=UTF-8 LucaProxy.jar' --tray >> ~/LucaProxy/lucaproxy.sh
chmod +x ~/LucaProxy/lucaproxy.sh
~/LucaProxy/lucaproxy.sh
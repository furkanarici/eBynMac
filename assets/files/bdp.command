cd /opt/ebyn;
JAVA_VERSION=$(/usr/libexec/java_home 2>/dev/null && java -version 2>&1 | grep -i version | cut -d'"' -f2 | cut -d'.' -f1)

# Initialize JAVA_OPTS as empty
JAVA_OPTS=""

# Check Java version and add options only for Java 9+
if [ "$JAVA_VERSION" -ge "9" ] 2>/dev/null; then
    # For Java 9 and newer, add the --add-opens flag
    JAVA_OPTS="--add-opens java.desktop/java.beans=ALL-UNNAMED"
    echo "Using Java $JAVA_VERSION with additional options: $JAVA_OPTS"
else
    # For Java 8 or older, no additional flags needed
    echo "Using Java $JAVA_VERSION, no additional options needed"
fi

java $JAVA_OPTS -Xmx256m -Dcom.cs.uid.renderer.java.runtime.UIBeanClassCache.packageName= -Dcom.cs.uid.renderer.java.runtime.UIBeanClassCache.checkForModification=false -classpath beydef.jar:bdp.jar:csfc.jar:debugger.jar:cs_mdi.jar:lf.jar:JavaRenderer.jar:ice-5_06_3.jar bdp_mf

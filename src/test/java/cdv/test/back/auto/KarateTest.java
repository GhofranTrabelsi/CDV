package cdv.test.back.auto;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Test;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import org.apache.commons.io.FileUtils;
import java.io.File;
import java.lang.module.Configuration;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


//@RunWith(Karate.class)
public class KarateTest {

    /**
     * Scenario reglement + paiement
     */
    @Test
    public void runAllTests() {
         Results results = Runner.path(
                        "classpath:cdv/test/back/auto/features/update_ijss/updateijss.feature"
                )
                .outputCucumberJson(true)
                .parallel(5);
     //   generateReport(results.getReportDir());
    }

   /* public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "CDV");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }*/
}



package com.m2at.testrunner;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;


@RunWith(Cucumber.class)
@CucumberOptions(
		features = "classpath:features", 
		glue = { "com.m2at.glue" }, 
		plugin = {"html:target/cucumber-html-report/regression-tests.html",
				  "com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"},
		tags = "@Debug"
)

public class DebugTestRunner {
	
}
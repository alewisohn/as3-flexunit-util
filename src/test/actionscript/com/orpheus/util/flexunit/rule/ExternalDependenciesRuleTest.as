package com.orpheus.util.flexunit.rule {

import org.flexunit.assertThat;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;

public class ExternalDependenciesRuleTest {		
	
	[Rule]
	public var dependencies:ExternalDependencyRule = new ExternalDependencyRule("http://www.google.com", "http://www.cnn.com");
	
	[Test]
	public function ruleShouldHaveLoadedMultipleDepedencies():void {
		assertThat(dependencies.getDependency(0), notNullValue());
		assertThat(dependencies.getDependency(1), notNullValue());
		assertThat(dependencies.getDependency(2), nullValue());
	}
}
}
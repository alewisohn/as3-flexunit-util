package com.orpheus.util.flexunit.rule {

import org.flexunit.assertThat;
import org.hamcrest.object.notNullValue;

public class ExternalDependencyRuleTest {		
	
	[Rule]
	public var dependencies:ExternalDependencyRule = new ExternalDependencyRule("http://www.google.com");
	
	[Test]
	public function ruleShouldHaveLoadedOneDepedency():void {
		assertThat(dependencies.getDependency(0), notNullValue());
	}
}
}
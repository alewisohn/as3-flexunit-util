package com.orpheus.util.flexunit.rule {

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

import org.flexunit.internals.runners.statements.MethodRuleBase;
import org.flexunit.rules.IMethodRule;
import org.flexunit.token.AsyncTestToken;

/**
 * The ExternalDependencyRule is useful for loading one or more external test 
 * fixtures prior to each test. 
 * 
 * @example
 * <Listing version="3.0">
 * public class UsingExternalDependencyRuleExample {
 * 
 * 	[Rule]
 * 	public var dependencies:ExternalDependencyRule = new ExternalDependencyRule("dependency.xml");
 * 
 * 	private var loadedDependency:XML;
 * 
 * 	[Before]
 * 	public function setup():void {
 * 		loadedDependency = new XML(dependencies.getDependency(0));		
 * 	}
 * 
 * 	[Test]
 * 	public function example():void {
 * 		assertThat(loadedDependency, notNullValue());
 * 	}
 * }
 * </Listing>
 * 
 * @author alewisohn
 */
public class ExternalDependencyRule extends MethodRuleBase implements IMethodRule {
	
	/**
	 * @private
	 * An array of loaded dependencies.
	 */
	private var dependencies:Array = [];
	
	/**
	 * @private
	 * An array containing 0-n dependency URLs.
	 */
	private var urls:Array;
	
	/**
	 * Constructor.
	 * 
	 * @param ...urls 0-n URLs
	 */
	public function ExternalDependencyRule(...urls) {
		this.urls = urls || [];
	}
	
	/**
	 * @private
	 */
	override public function evaluate(parentToken:AsyncTestToken):void {
		super.evaluate(parentToken);
		
		if (urls.length == 0) {
			proceedToNextStatement();
		} else {
			loadExternalDependency(urls.shift());
		}
	}
	
	/**
	 * @private
	 */
	override public function toString():String {
		return "ExternalDependencyRule";
	}
	
	/**
	 * Retrieve the content of the dependency at the given index.
	 * 
	 * @param index the index of the dependency to retrieve 
	 */
	public function getDependency(index:int):* {
		if (index >= dependencies.length) {
			return null;
		}
		return dependencies[index];
	}
	
	/**
	 * @private
	 */
	private function loadExternalDependency(url:String):void {
		var loader:URLLoader = new URLLoader();
		
		function loadeNext(event:Event):void {
			dependencies.push(loader.data);
			loader.removeEventListener(Event.COMPLETE, arguments.callee);
			if (urls.length > 0) { 
				loadExternalDependency(urls.shift()); 
			} else {
				proceedToNextStatement();	
			}
		}
		
		loader.addEventListener(Event.COMPLETE, loadeNext);
		loader.load(new URLRequest(url));
	}
}
}
#include <Preferences/PSSpecifier.h>
#include <Preferences/PSListController.h>
#import "./headers/MobileGesalt.h"

@interface PSUIAboutController : PSListController
-(id)specifierWithName:(NSString *)name value:(NSString *)value isCopyable:(BOOL)isCopyable;
-(NSString *)getLocalizationsPath:(NSString *)lang;
@end

%hook PSUIAboutController

%new
-(id)specifierWithName:(NSString *)name value:(NSString *)value isCopyable:(BOOL)isCopyable {
	PSSpecifier *specifier = [%c(PSSpecifier) new];
	specifier.identifier = name;
	specifier.name = name;
	specifier.target = self;
	[specifier setProperty:value forKey:@"value"];
	[specifier setProperty:[NSNumber numberWithBool:isCopyable] forKey:@"isCopyable"];
	specifier.cellType = 4;
	return specifier;
}

%new
-(NSString *)getLocalizationsPath:(NSString *)lang {
	NSString *defaultPath = @"/Library/WhatAboutThis/lang.lproj/Localizable.strings";
	defaultPath = [defaultPath stringByReplacingOccurrencesOfString:@"lang" withString:lang];

	if ([[NSFileManager defaultManager] fileExistsAtPath:defaultPath]) {
		return defaultPath;
	}

	return @"/Library/WhatAboutThis/base.lproj/Localizable.strings";
}

-(void)viewWillAppear:(BOOL)arg1 {
	%orig;
	//Remove
	[self removeSpecifierID:@"ProductVersion" animated:NO];
	[self removeSpecifierID:@"ProductModel" animated:NO];
	[self removeSpecifierID:@"SerialNumber" animated:NO];
	[self removeSpecifierID:@"WAT_SERIAL_NUMBER" animated:NO];
	[self removeSpecifierID:@"WAT_MODEL_NUMBER" animated:NO];
	[self removeSpecifierID:@"WAT_MODEL_NAME" animated:NO];
	[self removeSpecifierID:@"WAT_SOFTWARE_VERSION" animated:NO];
	//Add
	[self insertSpecifier:[self specifierWithName:@"WAT_SERIAL_NUMBER" value:nil isCopyable:TRUE] afterSpecifierID:@"NAME_CELL_ID" animated:NO];
	[self insertSpecifier:[self specifierWithName:@"WAT_MODEL_NUMBER" value:nil isCopyable:TRUE] afterSpecifierID:@"NAME_CELL_ID" animated:NO];
	[self insertSpecifier:[self specifierWithName:@"WAT_MODEL_NAME" value:nil isCopyable:TRUE] afterSpecifierID:@"NAME_CELL_ID" animated:NO];
	[self insertSpecifier:[self specifierWithName:@"WAT_SOFTWARE_VERSION" value:nil isCopyable:TRUE] afterSpecifierID:@"NAME_CELL_ID" animated:NO];
}

- (PSTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	PSTableCell *cell = %orig;

	NSDictionary *languageDic = [NSLocale componentsFromLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]];
	NSDictionary *localized = [NSDictionary dictionaryWithContentsOfFile:[self getLocalizationsPath:[languageDic objectForKey:@"kCFLocaleLanguageCodeKey"]]];

	if([cell.specifier.identifier isEqualToString:@"WAT_SOFTWARE_VERSION"]) {
		cell.textLabel.text = [localized objectForKey:@"SOFTWARE_VERSION"];
		cell.detailTextLabel.text = [[UIDevice currentDevice] systemVersion];
	}

	if([cell.specifier.identifier isEqualToString:@"WAT_MODEL_NAME"]) {
		cell.textLabel.text = [localized objectForKey:@"MODEL_NAME"];
		cell.detailTextLabel.text = (NSString*)MGCopyAnswer(kMGMarketingName);
	}

	if([cell.specifier.identifier isEqualToString:@"WAT_MODEL_NUMBER"]) {
		NSString *modelNumber = (NSString*)MGCopyAnswer(kMGModelNumber);
		NSString *regionInfo = (NSString*)MGCopyAnswer(kMGRegionInfo);
		regionInfo = [modelNumber stringByAppendingString : regionInfo];
		cell.textLabel.text = [localized objectForKey:@"MODEL_NUMBER"];
		cell.detailTextLabel.text = regionInfo;
	}

	if([cell.specifier.identifier isEqualToString:@"WAT_SERIAL_NUMBER"]) {
		cell.textLabel.text = [localized objectForKey:@"SERIAL_NUMBER"];
		cell.detailTextLabel.text = (NSString*)MGCopyAnswer(kMGSerialNumber);
	}

	return cell;	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];

	NSString *modelNumber = (NSString*)MGCopyAnswer(kMGModelNumber);
	NSString *regionInfo = (NSString*)MGCopyAnswer(kMGRegionInfo);
	regionInfo = [modelNumber stringByAppendingString : regionInfo];

	NSString *hwInfo = (NSString*)MGCopyAnswer(kMGRegulatoryModelNumber);
	NSString *buildNumber = (NSString*)MGCopyAnswer(kMGBuildVersion);

	NSString *versionForm = @"sv (bn)";

	versionForm = [versionForm stringByReplacingOccurrencesOfString:@"sv" withString:[[UIDevice currentDevice] systemVersion]];
	versionForm = [versionForm stringByReplacingOccurrencesOfString:@"bn" withString:buildNumber]; 

	if (indexPath.section == 0) {
		if ([cell.detailTextLabel.text isEqualToString:regionInfo]) {
			cell.detailTextLabel.text = hwInfo;
		} else if ([cell.detailTextLabel.text isEqualToString:hwInfo]) {
			cell.detailTextLabel.text = regionInfo;
		}

		if ([cell.detailTextLabel.text isEqualToString:[[UIDevice currentDevice] systemVersion]]) {
			cell.detailTextLabel.text = versionForm;
		} else if ([cell.detailTextLabel.text isEqualToString:versionForm]) {
			cell.detailTextLabel.text = [[UIDevice currentDevice] systemVersion];
		}
	}

	%orig;
}

-(void)reloadSpecifiers {
	//noob
}
%end

%hook AboutDataSource
-(void)performUpdates:(id)arg1 {
	//noob
}
%end
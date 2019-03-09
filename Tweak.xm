#import "./headers/MobileGesalt.h"

#define kSoftwareVersion @"SOFTWARE_VERSION"
#define kModelName @"MODEL_NAME"
#define kModelNumber @"MODEL_NUMBER"
#define kSerialNumber @"SERIAL_NUMBER"
#define LANG_BUNDLE_PATH @"/Library/Application Support/PeterDev/WhatAboutThis/Localizations.bundle"

static NSDictionary<NSString*, NSString*> *translationDict;

%hook PSUIAboutController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		int wat = 18;
		NSInteger watNSInt = (NSInteger) wat;
		return %orig + watNSInt;
	}

	return %orig;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"PSTableCell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell = [[%c(PSTableCell) alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		if (indexPath.row >= 1 & indexPath.row <= 14) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 15) {
			cell.textLabel.text = [translationDict objectForKey:kSoftwareVersion];
			cell.detailTextLabel.text = [[UIDevice currentDevice] systemVersion];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if (indexPath.row == 16) {
			NSString *modelName = (NSString*)MGCopyAnswer(kMGMarketingName);
			cell.textLabel.text = [translationDict objectForKey:kModelName];
			cell.detailTextLabel.text = modelName;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if (indexPath.row == 17) {
			NSString *modelNumber = (NSString*)MGCopyAnswer(kMGModelNumber);
			NSString *regionInfo = (NSString*)MGCopyAnswer(kMGRegionInfo);
			regionInfo = [modelNumber stringByAppendingString : regionInfo];
			cell.textLabel.text = [translationDict objectForKey:kModelNumber];
			cell.detailTextLabel.text = regionInfo;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if (indexPath.row == 18) {
			NSString *serialNumber = (NSString*)MGCopyAnswer(kMGSerialNumber);
			cell.textLabel.text = [translationDict objectForKey:kSerialNumber];
			cell.detailTextLabel.text = serialNumber;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
    }

	return %orig;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

	NSString *serialNumber = (NSString*)MGCopyAnswer(kMGSerialNumber);
	NSString *buildNumber = (NSString*)MGCopyAnswer(kMGBuildVersion);
	NSString *modelNumber = (NSString*)MGCopyAnswer(kMGModelNumber);
	NSString *regionInfo = (NSString*)MGCopyAnswer(kMGRegionInfo);
	NSString *versionForm = @"sv (bn)";

	versionForm = [versionForm stringByReplacingOccurrencesOfString:@"sv" withString:[[UIDevice currentDevice] systemVersion]];
	versionForm = [versionForm stringByReplacingOccurrencesOfString:@"bn" withString:buildNumber]; 
	regionInfo = [modelNumber stringByAppendingString : regionInfo];

	if (indexPath.section == 0) {
		if (indexPath.row >= 1 & indexPath.row <= 14) {
			return 0;
		}
	}

	if (indexPath.section == 1) {
		//Software Version
		if ([cell.detailTextLabel.text isEqualToString:versionForm]) {
			cell.hidden = YES;
			return 0;
		}
		//Model Number
		if ([cell.detailTextLabel.text isEqualToString:regionInfo]) {
			cell.hidden = YES;
			return 0;
		}
		//Serial Number
		if ([cell.detailTextLabel.text isEqualToString:serialNumber]) {
			cell.hidden = YES;
			return 0;
		}
	}

	return %orig;
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

%new
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0 & indexPath.row == 18) {
		return YES;
	}
    return NO;
}

%new
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	if (indexPath.section == 0 & indexPath.row == 18) {
		return (action == @selector(copy:));
	}
    return nil;
}

%new
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if (action == @selector(copy:)) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[UIPasteboard generalPasteboard] setString:cell.detailTextLabel.text];
    }
}
%end

%ctor{
	NSBundle *langBundle = [NSBundle bundleWithPath:LANG_BUNDLE_PATH];
        translationDict = @{
            kSoftwareVersion : langBundle ? [langBundle localizedStringForKey:kSoftwareVersion value:@"Software Version" table:nil] : @"Software Version",
            kModelName : langBundle ? [langBundle localizedStringForKey:kModelName value:@"Model Name" table:nil] : @"Model Name",
            kModelNumber : langBundle ? [langBundle localizedStringForKey:kModelNumber value:@"Model Number" table:nil] : @"Model Number",
            kSerialNumber : langBundle ? [langBundle localizedStringForKey:kSerialNumber value:@"Serial Number" table:nil] : @"Serial Number"
    };
}
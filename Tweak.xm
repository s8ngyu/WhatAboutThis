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
		return %orig + 5;
	}
	return %orig;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"WhatAboutThis";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		if (indexPath.row == 1) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 2) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.textLabel.text = [translationDict objectForKey:kSoftwareVersion];
			cell.detailTextLabel.text = [[UIDevice currentDevice] systemVersion];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if (indexPath.row == 3) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			NSString *modelName = (NSString*)MGCopyAnswer(kMGMarketingName);
			cell.textLabel.text = [translationDict objectForKey:kModelName];
			cell.detailTextLabel.text = modelName;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if (indexPath.row == 4) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			NSString *modelNumber = (NSString*)MGCopyAnswer(kMGModelNumber);
			NSString *regionInfo = (NSString*)MGCopyAnswer(kMGRegionInfo);
			regionInfo = [modelNumber stringByAppendingString : regionInfo];
			cell.textLabel.text = [translationDict objectForKey:kModelNumber];
			cell.detailTextLabel.text = regionInfo;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if (indexPath.row == 5) {
			NSString *serialNumber = (NSString*)MGCopyAnswer(kMGSerialNumber);
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.textLabel.text = [translationDict objectForKey:kSerialNumber];
			cell.detailTextLabel.text = serialNumber;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
    }

	if (indexPath.section == 1) {
		if (indexPath.row == 7) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.hidden = TRUE;
			return cell;
		}
		if (indexPath.row == 9) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.hidden = TRUE;
			return cell;
		}
		if (indexPath.row == 10) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.hidden = TRUE;
			return cell;
		}
	}

	return %orig;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 & indexPath.row == 1) {
		return 0;
	}
	if (indexPath.section == 1 & indexPath.row == 7) {
		return 0;
	}
	if (indexPath.section == 1 & indexPath.row == 9) {
		return 0;
	}
	if (indexPath.section == 1 & indexPath.row == 10) {
		return 0;
	}
    return %orig;
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
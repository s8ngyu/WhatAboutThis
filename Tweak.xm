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
		int wat = 21;
		NSInteger watNSInt = (NSInteger) wat;
		return %orig + watNSInt;
	}
	return %orig;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"WhatAboutThis";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell = [[%c(PSTableCell) alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		if (indexPath.row == 1) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 2) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 3) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 4) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 5) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
				}
		if (indexPath.row == 6) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
				}
		if (indexPath.row == 7) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 8) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 9) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 10) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 11) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if (indexPath.row == 12) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
		}
		if (indexPath.row == 13) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
		}
		if (indexPath.row == 14) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
		}
		if (indexPath.row == 15) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
		}
		if (indexPath.row == 16) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
		}
		if (indexPath.row == 17) {
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
		}
		if (indexPath.row == 18) {
			cell.textLabel.text = [translationDict objectForKey:kSoftwareVersion];
			cell.detailTextLabel.text = [[UIDevice currentDevice] systemVersion];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if (indexPath.row == 19) {
			NSString *modelName = (NSString*)MGCopyAnswer(kMGMarketingName);
			cell.textLabel.text = [translationDict objectForKey:kModelName];
			cell.detailTextLabel.text = modelName;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if (indexPath.row == 20) {
			NSString *modelNumber = (NSString*)MGCopyAnswer(kMGModelNumber);
			NSString *regionInfo = (NSString*)MGCopyAnswer(kMGRegionInfo);
			regionInfo = [modelNumber stringByAppendingString : regionInfo];
			cell.textLabel.text = [translationDict objectForKey:kModelNumber];
			cell.detailTextLabel.text = regionInfo;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if (indexPath.row == 21) {
			NSString *serialNumber = (NSString*)MGCopyAnswer(kMGSerialNumber);
			cell.textLabel.text = [translationDict objectForKey:kSerialNumber];
			cell.detailTextLabel.text = serialNumber;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
    }

	//Hide the originals
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
	if (indexPath.section == 0 & indexPath.row == 2) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 3) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 4) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 5) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 6) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 7) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 8) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 9) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 10) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 11) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 12) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 13) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 14) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 15) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 16) {
		return 0;
	}
	if (indexPath.section == 0 & indexPath.row == 17) {
		return 0;
	}
	//Hide the originals
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];

	NSString *modelNumber = (NSString*)MGCopyAnswer(kMGModelNumber);
	NSString *regionInfo = (NSString*)MGCopyAnswer(kMGRegionInfo);
	regionInfo = [modelNumber stringByAppendingString : regionInfo];

	NSString *hwInfo = (NSString*)MGCopyAnswer(kMGRegulatoryModelNumber);

	if ([cell.detailTextLabel.text isEqualToString:regionInfo]) {
		cell.detailTextLabel.text = hwInfo;
	} else if ([cell.detailTextLabel.text isEqualToString:hwInfo]) {
		cell.detailTextLabel.text = regionInfo;
	}

	%orig;
}

%new
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0 & indexPath.row == 21) {
		return YES;
	}
    return NO;
}

%new
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	if (indexPath.section == 0 & indexPath.row == 21) {
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
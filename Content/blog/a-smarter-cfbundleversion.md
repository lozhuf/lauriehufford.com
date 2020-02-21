---
title: A Smarter CFBundleVersion
date: 2017-04-19 20:15
description: A simple and practical solution for managing your app's build version.
---

When initially setting up the project for our iOS app at [Tjek](https://tjek.com), I spent a while trying to find a nice solution for generating the CFBundleVersion number.

My requirements were:

- **Unique**:  Every release must have a unique version.
- **Ever increasing**: A release's version should be greater than the previous release.
- **Automatic** :  The value should be dynamically generated.

Additionally, the resulting value needs to be version-control safe, by which I mean builds on multiple branches can't have the same build version. Most importantly, I didn't want to have to think about it  -  it should just be a unique identifier for every build out of Xcode.

## A matter of time

I investigated a number of possibilities and suggestions dotted around the internet, including manually updating the value, scripts for auto-incrementing the number, and using branch commit counts, but all seemed to have one or other flaw.

The solution I finally came to in the end seemed to solve all our needs, and I haven't seen it described elsewhere, so I hope it will be of use to others.

All you need is to run this short script as a Build Phase:

```bash
BUILD_NUMBER=$(date -u "+%y%m%d%H%M")
INFO_PLIST="${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BUILD_NUMBER" "$INFO_PLIST"
```

This generates a CFBundleVersion of the form `201704190842`. This may at first glance look like a rather unwieldy build number, but actually encodes a lot of useful information; if you squint your eyes just right it makes a bit more sense: `2017-04-19 08:42`.

![Back to the Future](/images/bttf_clock.gif)

It is unique (for all builds built more than a minute apart), is ever increasing (if you avoid building around DST changes), and mostly human-readable (you can cross-reference the date with source control commits, and also builds in the Xcode Organizer).

## Possible pitfalls

### Time Zones

If you have a team in multiple timezones you might end up with collisions if the timezone isnt normalized.

The above code snippet uses the GMT timezone (via the `-u` flag), but unfortunately this makes it a bit more complicated to cross-reference exact hours/minutes from the build time for those outside GMT. Usually, though, you would only be comparing at a month/day granularity, so in practice this isn't such a problem.

### App Extensions

As far as I understand it, extensions must have the same build version as the app that contains them. This is a more complicated nut to crack, but one that I believe is crackable (we dont currently have any extensions in our app, so we've avoided this problem so far).

---

Despite these possible wrinkles we have been successfully using it in production for the last 3 years. Obviously every project/team is different, so your mileage may vary, but I hope you find this useful too.

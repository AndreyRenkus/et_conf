#!/bin/sh
dmidecode | grep UUID | md5sum


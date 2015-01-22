module danger.s3_initialize;

import s3;
import std.stdio;
import std.process;
import std.string;

static this()
{
	S3_initialize(toStringz("s3"), S3_INIT_ALL, toStringz(environment.get("S3_HOSTNAME")));
}


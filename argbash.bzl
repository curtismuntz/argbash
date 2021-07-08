def _hexbin_generator_impl(ctx):
    for i in ctx.files.m4_files:
        args = [
            i.path,
            #            "-c",
            "-o " + ctx.outputs.out.path,
        ]
        print(args)

        ctx.actions.run(
            inputs = [i],
            outputs = [ctx.outputs.out],
            executable = ctx.executable.argbash_tool,
            arguments = args,
            progress_message = "Generating .sh file: %s" % ctx.outputs.out,
        )

hexbin_generator = rule(
    attrs = {
        "argbash_tool": attr.label(executable = True, cfg = "exec", allow_files = True),
        "m4_files": attr.label_list(allow_files = True),
        "out": attr.output(),
    },
    implementation = _hexbin_generator_impl,
)

def argbash_binary(name, srcs, m4_files):
    ARGBASH = "//:argbash"
    outs = hexbin_generator(
        name = name + "_gen",
        argbash_tool = ARGBASH,
        m4_files = srcs,
        out = name + "_gen.sh",
    )
    native.sh_binary(
        name = name,
        srcs = [name + "_gen.sh"],
        deps = [],
    )
    return

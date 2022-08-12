def _get_model_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.write(
        output = out,
    )

get_model = rule(
    implementation = _get_model_impl
)

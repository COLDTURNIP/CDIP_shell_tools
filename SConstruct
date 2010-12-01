env = Environment()
env['package'] = 'cdipShellTools'
env.Tool('smartinstall')

cdipPathUtils = env.File('cdipPathUtils.sh')
cdipSrcUtils = env.File('cdipSrcUtils.sh')
cdipTemplateRcDir = env.Dir('cdipTemplateRcDir')

env.InstallProgram(cdipPathUtils)
env.InstallProgram(cdipSrcUtils)
env.InstallProgram(cdipTemplateRcDir)


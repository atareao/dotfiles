return {
	entry = function(self, job)
		ya.err(job.args[1])  -- "hello"
		ya.err(job.args.foo) -- true
		ya.err(job.args.bar) -- "baz"
	end,
}

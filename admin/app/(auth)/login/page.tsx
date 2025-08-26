"use client"
import Link from 'next/link'
import { signIn } from 'next-auth/react'
import { useState } from 'react'

export default function LoginPage() {
  const [email, setEmail] = useState('admin@dhansatu.local')
  const [password, setPassword] = useState('admin123')
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault()
    setLoading(true)
    setError(null)
    const res = await signIn('credentials', { redirect: true, email, password, callbackUrl: '/' })
    if ((res as any)?.error) setError((res as any).error)
    setLoading(false)
  }

  return (
    <main className="min-h-screen grid place-items-center p-6 bg-slate-100">
      <div className="w-full max-w-sm p-6 bg-white rounded-lg border">
        <h1 className="text-xl font-semibold mb-4">Admin Login</h1>
        <form className="space-y-3" onSubmit={onSubmit}>
          <input className="w-full border rounded px-3 py-2" placeholder="Email" value={email} onChange={e => setEmail(e.target.value)} />
          <input className="w-full border rounded px-3 py-2" placeholder="Password" type="password" value={password} onChange={e => setPassword(e.target.value)} />
          <button className="w-full py-2 rounded bg-slate-900 text-white" disabled={loading}>{loading ? 'Signing in…' : 'Sign in'}</button>
          {error && <p className="text-sm text-red-600">{error}</p>}
        </form>
        <Link className="text-xs underline block mt-2" href="/">Back</Link>
      </div>
    </main>
  )
}


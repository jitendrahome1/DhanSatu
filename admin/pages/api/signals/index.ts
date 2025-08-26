import type { NextApiRequest, NextApiResponse } from 'next'

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const base = process.env.ADMIN_API_URL || 'http://localhost:8080'
  if (req.method === 'GET') {
    const r = await fetch(`${base}/api/signals`)
    const data = await r.json()
    res.status(200).json(data)
    return
  }
  res.status(405).json({ error: 'Method not allowed' })
}


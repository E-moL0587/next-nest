'use client';

import { useState } from 'react';

export default function Home() {
  const [message, setMessage] = useState('');

  const fetchMessage = async () => {
    try {
      const res = await fetch('http://localhost:3001/hello', {
        credentials: 'include'
      });
      const data = await res.json();
      setMessage(data.message);
    } catch (error) {
      console.error('Error fetching message:', error);
    }
  };

  return (
    <div style={{ padding: '50px', textAlign: 'center' }}>
      <h1>Next.js クライアント</h1>
      <button onClick={fetchMessage}>サーバーからメッセージを取得</button>
      {message && <p>{message}</p>}
    </div>
  );
}

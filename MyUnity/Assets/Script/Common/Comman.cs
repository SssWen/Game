using System;
using System.IO;
using ProtoBuf;

public class Comman {

	// 序列化
	public static byte[] Serialize<T>(T instance) {
		
		byte[] bytes = null;
		using (var ms = new MemoryStream ()) {
			
			Serializer.Serialize<T> (ms, instance);
			bytes = new byte[ms.Position];
			var fullBytes = ms.GetBuffer ();
			Array.Copy (fullBytes, bytes, bytes.Length);
		}

		return bytes;
	}

	// 反序列化
	public static T DeSerialize<T>(byte[] bytes) {
		
		using (var ms = new MemoryStream (bytes)) {
			
			return Serializer.Deserialize<T> (ms);
		}
	}
}

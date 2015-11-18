package glm;

import buddy.*;
import glm.Mat4;
using buddy.Should;

class TestMat4 extends BuddySuite {
	public function new() {
		describe('Using Mat4', {
			var ma:Mat4;
			before({
				ma = new Mat4();
			});

			it('should be able to create a zero matrix', {
				ma.zero();
				for(i in 0...4) {
					for(j in 0...4) {
						ma[i][j].should.beCloseTo(0);
					}
				}
			});
			it('should be able to create an identity matrix', {
				ma.identity();
				for(i in 0...4) {
					for(j in 0...4) {
						ma[i][j].should.beCloseTo(i == j ? 1 : 0);
					}
				}
			});
			it('should allow array access', {
				ma = new Mat4(4.2);
				ma[0][0].should.beCloseTo(4.2);
			});
			it('should be able to multliply vec4s with itself', {
				ma = Mat4.fromRows(
					new Vec4(1, 2, 3, 4),
					new Vec4(5, 6, 7, 8),
					new Vec4(9, 10, 11, 12),
					new Vec4(13, 14, 15, 16)
				);
				var r:Vec4 = ma * new Vec4(1, 1, 1, 1);
				r[0].should.beCloseTo(10);
				r[1].should.beCloseTo(26);
				r[2].should.beCloseTo(42);
				r[3].should.beCloseTo(58);
			});
			it('should be able to multliply mat4s with itself', {
				ma = Mat4.fromRows(
					new Vec4(1, 2, 3, 4),
					new Vec4(5, 6, 7, 8),
					new Vec4(9, 10, 11, 12),
					new Vec4(13, 14, 15, 16)
				);
				var mb:Mat4 = Mat4.fromRows(
					new Vec4(13, 14, 15, 16),
					new Vec4(9, 10, 11, 12),
					new Vec4(5, 6, 7, 8),
					new Vec4(1, 2, 3, 4)
				);
				var mc = ma * mb;
				var values:Array<Float> = [50, 60, 70, 80, 162, 188, 214, 240, 274, 316, 358, 400, 386, 444, 502, 560];
				for(i in 0...4) {
					for(j in 0...4) {
						mc[i][j].should.beCloseTo(values[(i * 4) + j]);
					}
				}
			});
			it('should be serializable', {
				ma = Mat4.fromRowArray([
					new Vec4(1, 2, 3, 4),
					new Vec4(5, 6, 7, 8),
					new Vec4(9, 10, 11, 12),
					new Vec4(13, 14, 15, 16)
				]);

				var s:haxe.Serializer = new haxe.Serializer();
				s.serialize(ma);
				var serialized:String = s.toString();

				var u:haxe.Unserializer = new haxe.Unserializer(serialized);
				var mb:Mat4 = u.unserialize();
				
				for(i in 0...4) {
					for(j in 0...4) {
						mb[i][j].should.beCloseTo(ma[i][j]);
					}
				}
			});

			after({
				ma = null;
			});
		});
	}
}
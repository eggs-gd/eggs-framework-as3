/**
 * Created by oburdun on 10/24/13.
 */
package
{

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;


	public class TestTest
	{
		public function TestTest()
		{

		}

		[Test]
		public function testing():void
		{
			assertThat(3, equalTo(3));
		}
	}
}

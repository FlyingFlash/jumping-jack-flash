package  com.flyingflash.utils{
   /**
   * VMath. 
   * A static class to perform basic match operations on 'infinitely' large unsigned 
   * integers to any base, represented as digits in Vector instances. 
   * 
   * Includes public methods to generate the necessary Vector instances from strings or uints. 
   **/
    public class VMath {
        private static var _base:uint = 10;

		public static function set base(base:uint){
			_base = base;
		}

        public static function vectorFromString(str:String):Vector.<uint>
        {
            return cloneToVector(str.split(""));
        }

        public static function vectorFromUint(n:uint):Vector.<uint>
        {
            return cloneToVector(n.toString().split(""));
        }

        public static function power(v:Vector.<uint>, n:int):Vector.<uint>
        {
            var vp:Vector.<uint> = cloneToVector(v);
            if (n==0){
                clear(vp);
                vp.push(1);
            }else{
                var v2:Vector.<uint> = cloneToVector(v);
                for (var iter:int=1; iter<n; iter++){
                    vProduct(vp, v2);
                }
            }
            return vp;
        }

        public static function sum(v1:Vector.<uint>, v2:Vector.<uint>)
        {
            var prevLen:int = v1.length;
            var v1Pos:int = v1.length-1;
            for (var iter=v2.length-1; iter>=0; iter--, v1Pos-- ){
                addToElement(v1, v1Pos, v2[iter]);
                if (v1.length > prevLen){
                    v1Pos++;
                    prevLen = v1.length;
                }
            }
        }

		public static function product(v:Vector.<uint>, n:int)
        {
            var vTemp:Vector.<uint> = cloneToVector(v);
            for (var iter:int=1; iter<n; iter++){
                sum(v, vTemp);
            }
        }
       
        public static function vProduct(v1:Vector.<uint>, v2:Vector.<uint>)
        {
            var vv1:Vector.<uint> = cloneToVector(v1)
            var vTot:Vector.<uint> = new Vector.<uint>();
            vTot.push(0);
            for (var iter:int=0;iter<v2.length;iter++){
                var mul:int = v2[iter]*Math.pow(_base, v2.length-iter-1);
                product(vv1,mul);
                sum(vTot,vv1);
                copyToVector(vv1,v1);
            }
            copyToVector(v1,vTot);
        }


        public static function getProduct(v1:Vector.<uint>, v2:Vector.<uint>):Vector.<uint>
        {
            var vv1:Vector.<uint> = cloneToVector(v1)
            var vTot:Vector.<uint> = new Vector.<uint>();
            vTot.push(0);
            for (var iter:int=0;iter<v2.length;iter++){
                var mul:int = v2[iter]*Math.pow(_base, v2.length-iter-1);
                product(vv1,mul);
                sum(vTot,vv1);
                copyToVector(vv1,v1);
            }
			return vTot;
        }


        public static function copyToVector(v:Vector.<uint>, av:*)
        {
            while(v.length) v.pop();
            for (var iter:int=0; iter<av.length; iter++){
                v.push(av[iter]);
            }
        }
       
        public static function cloneToVector(av:*):Vector.<uint>
        {
            var vNew:Vector.<uint> = new Vector.<uint>();
            for (var iter:int=0; iter<av.length; iter++){
                vNew.push(av[iter]);
            }
            return vNew;
        }
       
        public static function addToElement(v:Vector.<uint>, el:Number, n:Number)
        {
            var rem:Number;
            var carry:Number;
            if (el<0) {
                v.unshift(n);
                el=0;
            }else{
                v[el] += n;
            }
            if (v[el] > _base-1){
                var temp:Number = v[el];
                rem = temp % _base;
                carry = Math.floor(temp/_base);
                v[el] = rem;
                addToElement(v, el-1, carry);
            }
        }
       
        private static function clear(v:Vector.<uint>)
        {
            while (v.length) v.pop();
        }
       
        private static function zero(v:Vector.<uint>)
        {
            while (v.length) v.pop();
            v.push(0);
        }
    }
}

